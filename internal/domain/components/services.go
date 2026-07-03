package components

import "context"

type ServicesP struct {
	Id         int    `json:"id" db:"id"`
	Name       string `json:"name" db:"name"`
	Created_at string `json:"created_at" db:"created_at"`
}

type ValidateServicesP struct {
	Name string `json:"name" binding:"required,min=3"`
}

type InterfaceServicesP interface {
	GetServices(ctx context.Context) ([]*ServicesP, error)
}
