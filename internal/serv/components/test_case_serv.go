package components

import (
	"context"
	"fmt"
	"log"

	"opengine.com/m/internal/domain/components"
)

type TestCaseServ interface {
	TestCaseBySr(ctx context.Context, sr_id int) ([]*components.TestCase, error)
}

type TestCaseImpl struct {
	Repo components.InterfaceTestCase
}

func NewTestCaseServ(repo components.InterfaceTestCase) TestCaseServ {
	return &TestCaseImpl{
		Repo: repo,
	}
}

func (s *TestCaseImpl) TestCaseBySr(ctx context.Context, sr_id int) ([]*components.TestCase, error) {

	if sr_id <= 0 {
		log.Println("El Id debe ser un numero valido")
		return nil, fmt.Errorf("El id del sub-recurso es requerido")
	}

	test_case, err := s.Repo.TestCaseBySr(ctx, sr_id)
	if err != nil {
		return nil, fmt.Errorf("No se pudo obtener los registros asociados al sub-recurso %v", err.Error())

	}
	return test_case, nil

}
