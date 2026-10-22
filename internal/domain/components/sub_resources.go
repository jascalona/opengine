package components

import "context"

type SubResources struct {
	Id              string `json:"id" db:"id"`
	Resource_id     int    `json:"resource_id" db:"resource_id"`
	Cod_sub_product string `json:"cod_sub_product" db:"cod_sub_product"`
	Name            string `json:"name" db:"name"`
	Description     string `json:"description" db:"description"`
	Created_at      string `json:"created_at"`
}

type InterfaceSubResource interface {
	GetSubResources(ctx context.Context, resource_id int) ([]*SubResources, error)
}
