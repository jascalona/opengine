package serv

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"log"
	"math/rand"
	"net/http"
	"strings"
	"time"

	"opengine.com/m/cmd/config"
	gw "opengine.com/m/internal/domain/GW"
)

type ServInitCreditGW interface {
	InitCredit(ctx context.Context, tx *gw.CreditTransaction) error
	ListCredit(ctx context.Context) ([]*gw.CreditTransaction, error)
}

type ServInitCreditGWImpl struct {
	Repo       gw.InterfaceServiceCredit
	HTTPClient *http.Client // cliente http para el pooling de conexiones
	Cfg        config.ServiceConfig
}

func NewServInitCreditGW(repo gw.InterfaceServiceCredit, svcCfg config.ServiceConfig) ServInitCreditGW {
	return &ServInitCreditGWImpl{
		Repo: repo,
		HTTPClient: &http.Client{
			Timeout: 15 * time.Second,
		},
		Cfg: svcCfg,
	}
}

func (s *ServInitCreditGWImpl) ListCredit(ctx context.Context) ([]*gw.CreditTransaction, error) {

	transaction, err := s.Repo.ListCredit(ctx)
	if err != nil {
		log.Println("Error al obtener los registros: ", err.Error())
		return nil, fmt.Errorf("Error al obtener los registros")
	}
	return transaction, nil
}

func (s *ServInitCreditGWImpl) InitCredit(ctx context.Context, tx *gw.CreditTransaction) error {

	//------- Generador de transactionID
	transaction_Id := rand.New(rand.NewSource(time.Now().UnixNano()))

	long := 12
	const charts = "ABCD1234567890"

	var transaction_id strings.Builder
	for i := 0; i < long; i++ {
		index_id := transaction_Id.Intn(len(charts))
		transaction_id.WriteByte(charts[index_id])
	}
	// injeccion del string generado para el transactionId
	tx.TransactionId = transaction_id.String()

	//------- Generador del TraceID
	trace_Id := rand.New(rand.NewSource(time.Now().UnixNano()))
	var trace_id strings.Builder

	for i := 0; i < long; i++ {
		trace_index := trace_Id.Intn(len(charts))
		trace_id.WriteByte(charts[trace_index])
	}

	// injeccion del string para trace_id
	tx.TraceId = trace_id.String()

	// quemamos el userReferenceId para identificar de que herramienta se genero la operacion
	tx.UserId = "371D2E119F49"
	tx.UserReferenceId = "A9C46BCAEF43"
	tx.UserGroupId = "D3EE2EA3F757"
	tx.UserUniqueId = "371D2E119F52"
	tx.Product = "040"
	tx.SubProduct = "220"
	tx.ProductSypago = "DEBIT"     // Cambiado a DEBIT como tu Postman exitoso
	tx.SubProductSypago = "SYPAGO" // Cambiado a SYPAGO como tu Postman exitoso
	tx.ApprovalAgent = "OTHE"
	tx.SyPagoCreationChannel = "WEB-APP"
	tx.SyPagoAcceptanceChannel = "WEB-CHECKOUT"

	// =========================================================================================
	// LOGICA: Request HTTP al servicio GW | clausula de persistencia en bd para casos fallidos
	// =========================================================================================
	// serializacion del objeto completo ya construido a json

	endpoint := "/api/v1/transaction"
	fullURL := fmt.Sprintf("%s%s", s.Cfg.BaseURL, endpoint)

	bodyJSON, err := json.Marshal(tx)
	if err != nil {
		log.Println(bodyJSON)
		return fmt.Errorf("Error al serializar payload: %v", err)
	}

	// Creamos la peticion HTTP apuntando a la URL del config
	request, err := http.NewRequestWithContext(ctx, "POST", fullURL, bytes.NewBuffer(bodyJSON))
	if err != nil {
		return fmt.Errorf("error al crear request http: %w", err)
	}

	request.Header.Set("Content-Type", "application/json")

	// Control de autenticacion
	if s.Cfg.Username != "" && s.Cfg.Password != "" {
		request.SetBasicAuth(s.Cfg.Username, s.Cfg.Password)
	}

	resp, err := s.HTTPClient.Do(request)
	if err != nil {
		log.Println("Error de conectividad con servicio externo: ", err.Error())
		return fmt.Errorf("servicio externo no disponible")
	}
	defer resp.Body.Close()

	// Evaluar estatus 201 OK
	if resp.StatusCode != http.StatusCreated {
		log.Printf("Validacion rechazada. Status recibido: %d (%s)", resp.StatusCode, resp.Status)
		log.Println("REQUEST INVOCADO PARA SYGATEWAY", fullURL)
		//log.Println(resp)
		return fmt.Errorf("la validacion del servicio externo retorno estatus %d", resp.StatusCode)
	}

	nowStr := time.Now().Format("2006-01-02T15:04:05")
	tx.SypagoProcessDate = &nowStr

	// =========================================================================================
	// PERSISTENCIA EN BD PARA EL CASO DE EXITO
	// =========================================================================================

	err = s.Repo.InitCredit(ctx, tx)
	if err != nil {
		log.Println("Error al procesar la solicitud: ", err.Error())
		fmt.Println(tx)
		return fmt.Errorf("No se pudo generar la transaccion: %v", err.Error())
	}
	return nil
}
