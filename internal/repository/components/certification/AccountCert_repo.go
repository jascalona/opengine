package certification

import (
	"context"
	"database/sql"
	"log"

	"opengine.com/m/internal/domain/components/certification"
)

type AccountCertRepo struct {
	DB *sql.DB
}

func NewAccountCert(db *sql.DB) certification.InterfaceAccountCert {
	return &AccountCertRepo{DB: db}
}

func (r *AccountCertRepo) GetAccountCert(ctx context.Context) ([]*certification.AccountCertification, error) {
	query := `
		SELECT
			id,
			account_origin,
			name,
			document_id,
			agent,
			cnta,
			cele,
			is_active,
			collector,
			contract,
			created_at
		FROM account_certification`

	rows, err := r.DB.QueryContext(ctx, query)

	if err != nil {
		log.Println("Error al correr el query")
		return nil, err
	}

	accounts := make([]*certification.AccountCertification, 0)

	for rows.Next() {
		list := &certification.AccountCertification{}
		err := rows.Scan(
			&list.Id,
			&list.AccountOrigin,
			&list.Name,
			&list.DocumentId,
			&list.Agent,
			&list.Cnta,
			&list.Cele,
			&list.IsActive,
			&list.Collector,
			&list.Contract,
			&list.Created_at,
		)

		if err != nil {
			log.Println("Error al aplicar el escanner: ", err.Error())
			return nil, err
		}

		accounts = append(accounts, list)
	}

	if err := rows.Err(); err != nil {
		log.Println("Error al realizar la iteracion: ", err.Error())
		return nil, err
	}

	return accounts, nil

}
