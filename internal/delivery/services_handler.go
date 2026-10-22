package delivery

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"opengine.com/m/internal/serv/components"
)

type ServicesHandler struct {
	Services components.ServicesServ
}

func NewServicesHandler(s components.ServicesServ) *ServicesHandler {
	return &ServicesHandler{Services: s}
}

func (h *ServicesHandler) GetServices(c *gin.Context) {

	services, err := h.Services.GetServices(c.Request.Context())
	if err != nil {
		log.Println("Error interno del servicio")
		c.JSON(http.StatusInternalServerError, gin.H{"Error interno": err.Error()})
		return
	}
	c.JSON(http.StatusOK, services)
}
