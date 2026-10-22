package delivery

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"opengine.com/m/internal/serv/components/certification"
)

type AccountCertHandler struct {
	Service certification.AccountCertServ
}

func NewAccountCert(s certification.AccountCertServ) *AccountCertHandler {
	return &AccountCertHandler{Service: s}
}

func (s *AccountCertHandler) GetAccountCert(c *gin.Context) {

	account, err := s.Service.GetAccountCert(c.Request.Context())
	if err != nil {
		log.Println("Error interno: ", err.Error())
		c.JSON(http.StatusInternalServerError, gin.H{"Error interno: ": err.Error()})
		return
	}

	c.JSON(http.StatusOK, account)
}
