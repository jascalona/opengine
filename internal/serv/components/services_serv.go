package components

import (
	"context"
	"fmt"
	"log"

	"opengine.com/m/internal/domain/components"
)

type ServicesServ interface {
	GetServices(ctx context.Context) ([]*components.ServicesP, error)
}

type ServicesImpl struct {
	Repo components.InterfaceServicesP
}

func NewServicesServ(repo components.InterfaceServicesP) ServicesServ {
	return &ServicesImpl{
		Repo: repo,
	}
}

func (s *ServicesImpl) GetServices(ctx context.Context) ([]*components.ServicesP, error) {
	services, err := s.Repo.GetServices(ctx)
	if err != nil {
		log.Println("Error al obtener los registros: ", err.Error())
		return nil, fmt.Errorf("Error al obtener los registros")
	}
	return services, nil
}
