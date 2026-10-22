package components

import (
	"context"
	"fmt"

	"opengine.com/m/internal/domain/components"
)

type SubResourcesServ interface {
	GetSubResources(ctx context.Context, resource_id int) ([]*components.SubResources, error)
}

type SubResourcesImpl struct {
	Repo components.InterfaceSubResource
}

func NewSubRespurcesServ(repo components.InterfaceSubResource) SubResourcesServ {
	return &SubResourcesImpl{
		Repo: repo,
	}
}

func (s *SubResourcesImpl) GetSubResources(ctx context.Context, resources_id int) ([]*components.SubResources, error) {

	if resources_id <= 0 {
		return nil, fmt.Errorf("El id del recurso es requerido")
	}

	sub_resources, err := s.Repo.GetSubResources(ctx, resources_id)

	if err != nil {
		return nil, fmt.Errorf("No se pudo obtener los registros asociados al recurso: %v", err.Error())
	}
	return sub_resources, nil
}
