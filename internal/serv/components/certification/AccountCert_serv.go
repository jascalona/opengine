package certification

import (
	"context"
	"fmt"
	"log"

	"opengine.com/m/internal/domain/components/certification"
)

type AccountCertServ interface {
	GetAccountCert(ctx context.Context) ([]*certification.AccountCertification, error)
}

type AccountCertImpl struct {
	Repo certification.InterfaceAccountCert
}

func NewAccountCertServ(repo certification.InterfaceAccountCert) AccountCertServ {
	return &AccountCertImpl{
		Repo: repo,
	}
}

func (s *AccountCertImpl) GetAccountCert(ctx context.Context) ([]*certification.AccountCertification, error) {

	account, err := s.Repo.GetAccountCert(ctx)
	if err != nil {
		log.Println("Error al obtener los registros: ", err.Error())
		return nil, fmt.Errorf("Error al obtener los registros: %v", err.Error())
	}

	return account, nil
}
