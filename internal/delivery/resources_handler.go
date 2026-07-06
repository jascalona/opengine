package delivery

import (
	"log"
	"net/http"
	"strconv"

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

func (h *ResourcesHandler) ResourcesByServices(c *gin.Context) {
	IdStr := c.Query("id")

	resourcesId, err := strconv.Atoi(IdStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"Error: ": "El ID debe ser un numero valido"})
		return
	}

	list_resources, err := h.Service.ResourcesByServices(c.Request.Context(), resourcesId)
	if err != nil {
		log.Printf("Error al obtener los recursos asociados %d: %v", list_resources, err)
		c.JSON(http.StatusInternalServerError, gin.H{"Error interno: ": err.Error()})
		return
	}

	c.JSON(http.StatusOK, list_resources)
}
