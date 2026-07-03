package components

import (
	"context"
	"database/sql"
	"log"

	"opengine.com/m/internal/domain/components"
)

type ServicespRepo struct {
	DB *sql.DB
}

func NewServicespRepo(db *sql.DB) components.InterfaceServicesP {
	return &ServicespRepo{DB: db}
}

func (r *ServicespRepo) GetServices(ctx context.Context) ([]*components.ServicesP, error) {

	query := `SELECT id,name,created_at from services`

	rows, err := r.DB.QueryContext(ctx, query)

	if err != nil {
		log.Println("Error al correr el query", err.Error())
		return nil, err
	}

	services := make([]*components.ServicesP, 0)

	for rows.Next() {
		list := &components.ServicesP{}
		err := rows.Scan(
			&list.Id,
			&list.Name,
			&list.Created_at,
		)
		if err != nil {
			log.Println("no hay registros para iterar")
			return nil, err
		}

		services = append(services, list)
	}

	if err := rows.Err(); err != nil {
		return nil, err
	}

	return services, nil
}
