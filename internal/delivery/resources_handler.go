package delivery

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	"opengine.com/m/internal/serv/components"
)

type ResourcesHandler struct {
	Service components.ResourcesServ
}

func NewResourcesHandler(s components.ResourcesServ) *ResourcesHandler {
	return &ResourcesHandler{Service: s}
}

func (h *ResourcesHandler) GetResources(c *gin.Context) {
	resources, err := h.Service.GetResources(c.Request.Context())
	if err != nil {
		log.Println("Error al procesar la peticion: ", err.Error())
		c.JSON(http.StatusInternalServerError, gin.H{"Error interno: ": err.Error()})
		return
	}
	c.JSON(http.StatusOK, resources)
}
