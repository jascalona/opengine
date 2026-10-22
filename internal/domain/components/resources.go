package components

import "context"

type Resources struct {
	Id          int    `json:"id" db:"id"`
	Services_id int    `json:"services_id" db:"services_id"`
	Name        string `json:"name" db:"name"`
	Created_at  string `json:"created_at" db:"created_at"`
}

type ValidationResources struct {
	Services_id int    `json:"services_id" binding:"required"`
	Name        string `json:"name" binding:"required,min=3"`
}

type InterfaceResources interface {
	GetResources(ctx context.Context) ([]*Resources, error)
	ResourcesByServices(ctx context.Context, id int) ([]*Resources, error)
}
