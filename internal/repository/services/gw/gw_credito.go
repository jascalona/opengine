package repository

import (
	"context"
	"database/sql"
	"encoding/json"
	"log"

	gw "opengine.com/m/internal/domain/services/gw"
)

type RepoInitCreditGW struct {
	DB *sql.DB
}

func NewRepoInitCreditGW(db *sql.DB) gw.InterfaceServiceCredit {
	return &RepoInitCreditGW{DB: db}
}

func (r *RepoInitCreditGW) InitCredit(ctx context.Context, tx *gw.CreditTransaction) error {

	query := `
        INSERT INTO transactionsgw (
            trace_id,
            transaction_id,
            user_id,
            user_reference_id,
            user_group_id,
            user_unique_id,
            creation_date,
            sypago_init_date,
            sypago_process_date,
            product,
            sub_product,
            product_sypago,
            sub_product_sypago,
            approval_agent,
            sypago_creation_channel,
            sypago_acceptance_channel,
            issuing_agent,
            receiving_agent,
            amount,
            issuing_user, 
            receiving_user,
            status,
            rejected_code,
			end_to_end)VALUES($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20,$21,$22,$23,$24)`

	amountJSON, err := json.Marshal(tx.Amount)
	if err != nil {
		return err
	}
	issuingUserJSON, err := json.Marshal(tx.IssuingUser)
	if err != nil {
		return err
	}
	receivingUserJSON, err := json.Marshal(tx.ReceivingUser)
	if err != nil {
		return err
	}

	_, err = r.DB.ExecContext(ctx, query,
		tx.TraceId,
		tx.TransactionId,
		tx.UserId,
		tx.UserReferenceId,
		tx.UserGroupId,
		tx.UserUniqueId,
		tx.CreationDate,
		tx.SypagoInitDate,
		tx.SypagoProcessDate,
		tx.Product,
		tx.SubProduct,
		tx.ProductSypago,
		tx.SubProductSypago,
		tx.ApprovalAgent,
		tx.SyPagoCreationChannel,
		tx.SyPagoAcceptanceChannel,
		tx.IssuingAgent,
		tx.ReceivingAgent,
		amountJSON,
		issuingUserJSON,
		receivingUserJSON,
		tx.Status,
		tx.RejectedCode,
		tx.EndToEndId,
	)

	if err != nil {
		log.Println("Error al correr el query: ", err.Error())
		return err
	}

	return nil

}

func (r *RepoInitCreditGW) ListCredit(ctx context.Context) ([]*gw.CreditTransaction, error) {
	query := `
		SELECT 
			trace_id,
			transaction_id,
			user_id,
			user_reference_id,
			user_group_id,
			user_unique_id,
			creation_date,
			sypago_init_date,
			sypago_process_date,
			product,
			sub_product,
			product_sypago,
			sub_product_sypago,
			approval_agent,
			sypago_creation_channel,
			sypago_acceptance_channel,
			issuing_agent,
			receiving_agent,
			amount,
			issuing_user, 
			receiving_user
		FROM transactionsGW`

	rows, err := r.DB.QueryContext(ctx, query)
	if err != nil {
		log.Println("Error al correr el query: ", err.Error())
		return nil, err
	}

	transactionsCredit := make([]*gw.CreditTransaction, 0)

	for rows.Next() {
		rowsT := &gw.CreditTransaction{}
		// recibe el jsonb
		var Amount []byte
		var IssuingUser []byte
		var ReceivingUser []byte

		err := rows.Scan(
			&rowsT.TraceId,
			&rowsT.TransactionId,
			&rowsT.UserId,
			&rowsT.UserReferenceId,
			&rowsT.UserGroupId,
			&rowsT.UserUniqueId,
			&rowsT.CreationDate,
			&rowsT.SypagoInitDate,
			&rowsT.SypagoProcessDate,
			&rowsT.Product,
			&rowsT.SubProduct,
			&rowsT.ProductSypago,
			&rowsT.SubProductSypago,
			&rowsT.ApprovalAgent,
			&rowsT.SyPagoCreationChannel,
			&rowsT.SyPagoAcceptanceChannel,
			&rowsT.IssuingAgent,
			&rowsT.ReceivingAgent,
			&Amount,
			&IssuingUser,
			&ReceivingUser,
		)

		if err != nil {
			return nil, err
		}
		transactionsCredit = append(transactionsCredit, rowsT)
	}
	if err := rows.Err(); err != nil {
		return nil, err
	}
	return transactionsCredit, nil
}
