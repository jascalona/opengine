package components

import (
	"database/sql"
	"log"

	"golang.org/x/net/context"
	"opengine.com/m/internal/domain/components"
)

type TestCaseRepo struct {
	DB *sql.DB
}

func NewTestCaseRepo(db *sql.DB) components.InterfaceTestCase {
	return &TestCaseRepo{DB: db}
}

func (r *TestCaseRepo) TestCaseBySr(ctx context.Context, sr_id int) ([]*components.TestCase, error) {
	query := `
		SELECT 
			id,
			resource_id,
			subresource_id,
			name,
			account_type,
			expected_http,
			status,
			created_at
		FROM test_case WHERE subresource_id = $1`

	rows, err := r.DB.QueryContext(ctx, query, sr_id)

	if err != nil {
		log.Println("Error al correr el query: ", err.Error())
		return nil, err
	}

	defer rows.Close()

	var test_suite []*components.TestCase

	for rows.Next() {
		list := &components.TestCase{}
		err := rows.Scan(
			&list.Id,
			&list.IdResources,
			&list.IdSubResources,
			&list.Name,
			&list.AccountType,
			&list.ExpectedHttp,
			&list.Status,
			&list.Created_at,
		)

		if err != nil {
			log.Println("Error al aplicar el escanner: ", err.Error())
			return nil, err
		}

		test_suite = append(test_suite, list)
	}

	return test_suite, nil
}
