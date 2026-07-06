package components

import "context"

type TestCase struct {
	Id             string `json:"id" db:"id"`
	IdResources    int    `json:"resource_id" db:"resource_id"`
	IdSubResources int    `json:"subresource_id" db:"subresource_id"`
	Name           string `json:"name" db:"name"`
	AccountType    string `json:"account_type" db:"account_type"`
	ExpectedHttp   string `json:"expected_http" db:"expected_http"`
	Status         string `json:"status" db:"status"`
	Created_at     string `json:"created_at" db:"created_at"`
}

type InterfaceTestCase interface {
	GetTestCase(ctx context.Context) ([]*TestCase, error)
}
