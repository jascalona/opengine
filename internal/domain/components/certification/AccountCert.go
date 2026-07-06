package certification

import "context"

type AccountCertification struct {
	Id            int     `json:"id" db:"id"`
	AccountOrigin string  `json:"account_origin" db:"account_origin"`
	Name          string  `json:"name" db:"name"`
	DocumentId    string  `json:"document_id" db:"document_id"`
	Agent         string  `json:"agent" db:"agent"`
	Cnta          *string `json:"cnta" db:"cnta"`
	Cele          *string `json:"cele" db:"cele"`
	IsActive      *bool   `json:"is_active" db:"is_active"`
	Collector     *bool   `json:"collector" db:"collector"`
	Contract      *string `json:"contract" db:"contract"`
	Created_at    string  `json:"created_at" db:"created_at"`
}

type InterfaceAccountCert interface {
	GetAccountCert(ctx context.Context) ([]*AccountCertification, error)
}
