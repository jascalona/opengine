package components

import (
	"context"
	"database/sql"
	"log"

	"opengine.com/m/internal/domain/components"
)

type ResourcesRepo struct {
	DB *sql.DB
}

func NewResourcesRepo(db *sql.DB) components.InterfaceResources {
	return &ResourcesRepo{DB: db}
}

func (r *ResourcesRepo) GetResources(ctx context.Context) ([]*components.Resources, error) {

	query := `SELECT id, services_id, name, created_at FROM resources`

	rows, err := r.DB.QueryContext(ctx, query)

	if err != nil {
		log.Println("Error al correr el query: ", err.Error())
		return nil, err
	}

	resources := make([]*components.Resources, 0)

	for rows.Next() {
		list := &components.Resources{}
		err := rows.Scan(
			&list.Id,
			&list.Services_id,
			&list.Name,
			&list.Created_at,
		)

		if err != nil {
			return nil, err
		}

		resources = append(resources, list)
	}

	return resources, nil

}

func (r *ResourcesRepo) ResourcesByServices(ctx context.Context, id int) ([]*components.Resources, error) {
	query := `SELECT id, services_id, name, created_at FROM resources WHERE services_id = $1`

	rows, err := r.DB.QueryContext(ctx, query, id)
	if err != nil {
		log.Println("Error al correr el query: ", err.Error())
		return nil, err
	}

	defer rows.Close()

	var resources []*components.Resources

	for rows.Next() {
		list := &components.Resources{}
		err := rows.Scan(
			&list.Id,
			&list.Services_id,
			&list.Name,
			&list.Created_at,
		)
		if err != nil {
			log.Println("Error al realizar el escaner: ", err.Error())
			return nil, err
		}

		resources = append(resources, list)
	}
	return resources, nil
}
