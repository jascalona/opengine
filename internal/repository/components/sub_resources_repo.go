package components

import (
	"context"
	"database/sql"
	"log"

	"opengine.com/m/internal/domain/components"
)

type SubResourcesRepo struct {
	DB *sql.DB
}

func NewSubResourcesRepo(db *sql.DB) components.InterfaceSubResource {
	return &SubResourcesRepo{DB: db}
}

func (r *SubResourcesRepo) GetSubResources(ctx context.Context, resource_id int) ([]*components.SubResources, error) {

	query := `
		SELECT
			id,
			resource_id, 
			cod_sub_product,
			name,
			description,
			create_at
		FROM subresources WHERE resource_id = $1`

	rows, err := r.DB.QueryContext(ctx, query, resource_id)

	if err != nil {
		log.Println("Error al correr el query: ", err.Error())
		return nil, err
	}

	defer rows.Close()

	var sub_resources []*components.SubResources

	for rows.Next() {
		list := &components.SubResources{}
		err := rows.Scan(
			&list.Id,
			&list.Resource_id,
			&list.Cod_sub_product,
			&list.Name,
			&list.Description,
			&list.Created_at,
		)
		if err != nil {
			log.Println("Error al aplicar el escaner: ", err.Error())
			return nil, err
		}

		sub_resources = append(sub_resources, list)
	}

	return sub_resources, nil

}
