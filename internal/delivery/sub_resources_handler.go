package delivery

import (
	"log"
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"opengine.com/m/internal/serv/components"
)

type SubResourcesHandler struct {
	Service components.SubResourcesServ
}

func NewSubResourcesHandler(s components.SubResourcesServ) *SubResourcesHandler {
	return &SubResourcesHandler{Service: s}
}

func (h *SubResourcesHandler) GetSubResources(c *gin.Context) {

	idStr := c.Query("id")

	resourceId, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"Error: ": "El ID debe ser un numero valido"})
		return
	}

	list_sub_resource, err := h.Service.GetSubResources(c.Request.Context(), resourceId)
	if err != nil {
		log.Printf("Error al obtener los sub-recursos asociados %d: %v", list_sub_resource, err)
		c.JSON(http.StatusInternalServerError, gin.H{"Error interno: ": err.Error()})
		return
	}
	c.JSON(http.StatusOK, list_sub_resource)
}
