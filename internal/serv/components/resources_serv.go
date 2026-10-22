package components

import (
	"context"
	"fmt"
	"log"

	"opengine.com/m/internal/domain/components"
)

type ResourcesServ interface {
	GetResources(ctx context.Context) ([]*components.Resources, error)
	ResourcesByServices(ctx context.Context, id int) ([]*components.Resources, error)
}

type ResourcesImpl struct {
	Repo components.InterfaceResources
}

func NewResourcesServ(repo components.InterfaceResources) ResourcesServ {
	return &ResourcesImpl{
		Repo: repo,
	}
}

func (s *ResourcesImpl) GetResources(ctx context.Context) ([]*components.Resources, error) {
	resources, err := s.Repo.GetResources(ctx)
	if err != nil {
		log.Println("Error al obtener los registros: ", err.Error())
		return nil, fmt.Errorf("Error al obtener los registros: %v", err.Error())
	}
	return resources, nil
}

func (s *ResourcesImpl) ResourcesByServices(ctx context.Context, id int) ([]*components.Resources, error) {
	if id <= 0 {
		return nil, fmt.Errorf("Error al obtener los registros")
	}

	resources, err := s.Repo.ResourcesByServices(ctx, id)

	if err != nil {
		return nil, fmt.Errorf("No se pudo obtener los registros asociados al servicio : %s", id)
	}

	return resources, nil
}
