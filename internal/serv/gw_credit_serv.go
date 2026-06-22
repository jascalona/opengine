package serv

import (
	"context"
	"fmt"
	"log"
	"math/rand"
	"strings"
	"time"

	gw "opengine.com/m/internal/domain/GW"
)

type ServInitCreditGW interface {
	InitCredit(ctx context.Context, tx *gw.CreditTransaction) error
	ListCredit(ctx context.Context) ([]*gw.CreditTransaction, error)
}

type ServInitCreditGWImpl struct {
	Repo gw.InterfaceServiceCredit
}

func NewServInitCreditGW(repo gw.InterfaceServiceCredit) ServInitCreditGW {
	return &ServInitCreditGWImpl{
		Repo: repo,
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
	tx.UserId = "15872E119F77"
	tx.UserReferenceId = "15872E119F77"

	// logica para la asignacion de group_id por lotes (pendiente)
	tx.UserGroupId = "D3EE2EA3F757"
	tx.UserUniqueId = "15872E119F77"

	// Detalles estaticos
	tx.ProductSypago = "CREDIT"
	tx.SubProductSypago = "SYPAGO-TOOL"
	tx.ApprovalAgent = "OTHE"
	tx.SyPagoCreationChannel = "CLI-TOOL"
	tx.SyPagoAcceptanceChannel = "CIL-GW"

	err := s.Repo.InitCredit(ctx, tx)
	if err != nil {
		log.Println("Error al procesar la solicitud: ", err.Error())
		fmt.Println(tx)
		return fmt.Errorf("No se pudo generar la transaccion: %v", err.Error())
	}
	return nil
}
