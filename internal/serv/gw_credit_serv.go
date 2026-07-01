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

	// ------- Generador de transactionID
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

	// ------- Generador del TraceID
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
	tx.ProductSypago = "CREDIT"
	tx.SubProductSypago = "SYPAGO"
	tx.ApprovalAgent = "OTHE"
	tx.SyPagoCreationChannel = "TOOLS-QA"
	tx.SyPagoAcceptanceChannel = "TOOLS-QA"

	// =========================================================================================
	// LOGICA: Request HTTP al servicio GW | clausula de persistencia en bd para casos fallidos
	// =========================================================================================
	// serializacion del objeto completo ya construido a json

	endpoint := "/api/v1/transaction"

	InitURL := fmt.Sprintf("%s%s", s.Cfg.BaseURL, endpoint)

	// CONFIGURAR LA RUTA PARA TRABAJAR EL GET_TRANSACTION Y CONOCER EL ESTADO DE LA OPERACION DESDE QUE INICIA PARA INYECTAR EL VALOR EN LA BD
	getURL := fmt.Sprintf("%s%s?transaction_id=%s", s.Cfg.BaseURL, endpoint, tx.TransactionId)

	// cuerpo del msj
	bodyJSON, err := json.Marshal(struct {
		*gw.CreditTransaction // Hereda todos los campos originales con sus valores

		// Sobreescribimos estos 3 campos con omitempty para que no viajen en este JSON
		Status       string `json:"status,omitempty"`
		RejectedCode string `json:"rejected_code,omitempty"`
		EndToEndId   string `json:"end_to_end,omitempty"`
	}{
		CreditTransaction: tx, // enviamos en objeto original
	})

	if err != nil {
		log.Println(bodyJSON)
		return fmt.Errorf("Error al serializar payload: %v", err)
	}

	// peticion (Iniciacion del credito)
	request, err := http.NewRequestWithContext(ctx, "POST", InitURL, bytes.NewBuffer(bodyJSON))
	if err != nil {
		return fmt.Errorf("Error al enviar el request http: %w", err)
	}

	if err != nil {
		return fmt.Errorf("Error al enviar el request http: %w", err)
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
		log.Println("REQUEST INVOCADO PARA SYGATEWAY", InitURL)
		//log.Println(resp)
		return fmt.Errorf("la validacion del servicio externo retorno estatus %d", resp.StatusCode)
	}

	// =========================================================================================
	// STS (ESTADO DE LA OPERACION)
	// =========================================================================================
	sts, err := http.NewRequestWithContext(ctx, "GET", getURL, nil)
	if err != nil {
		return fmt.Errorf("Error al crear request GET: %w", err)
	}
	sts.Header.Set("Content-Type", "application/json")
	if s.Cfg.Username != "" && s.Cfg.Password != "" {
		sts.SetBasicAuth(s.Cfg.Username, s.Cfg.Password)
	}

	// consulta GET
	respStatus, err := s.HTTPClient.Do(sts)
	if err != nil {
		log.Println("Error al consultar el estado de la operacion: ", err.Error())
		return fmt.Errorf("no se pudo consultar el estado de la transaccion")
	}
	defer respStatus.Body.Close()

	if respStatus.StatusCode != http.StatusOK {
		log.Printf("Error al consultar estado. Status recibido: %d", respStatus.StatusCode)
		return fmt.Errorf("el servicio de consulta retorno estatus %d", respStatus.StatusCode)
	}

	// DECODIFICADOR DEL STS
	var statusData gw.ResponseStatusGW

	// json.NewDecoder lee directamente el flujo de bytes de respStatus.Body y lo mapea al struct
	err = json.NewDecoder(respStatus.Body).Decode(&statusData)
	if err != nil {
		log.Println("Error al decodificar el JSON del estado: ", err.Error())
		return fmt.Errorf("error al procesar la respuesta del servicio de estado")
	}

	log.Println("STS generado con Exito")
	log.Printf("Estado actual: %s, Tipo RJCT: %s EndToEndId: %s", statusData.Status, statusData.RejectedCode, statusData.BankLongReference)

	nowStr := time.Now().Format("2006-01-02T15:04:05")
	tx.Status = statusData.Status
	tx.RejectedCode = statusData.RejectedCode
	tx.EndToEndId = statusData.BankLongReference
	tx.SypagoProcessDate = &nowStr

	// =========================================================================================
	// PERSISTENCIA EN BD PARA EL CASO DE EXITO
	// =========================================================================================

	err = s.Repo.InitCredit(ctx, tx)
	if err != nil {
		log.Println("Error al procesar la solicitud: ", err.Error())
		fmt.Println("Persistencia en BD", tx)
		return fmt.Errorf("No se pudo generar la transaccion: %v", err.Error())
	}
	return nil
}
