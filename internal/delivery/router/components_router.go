package router

import (
	"github.com/gin-gonic/gin"
	"opengine.com/m/internal/delivery"
)

type RouterComponents struct {
	components_sv *delivery.ServicesHandler
}

func NewRouterComponents(
	components *delivery.ServicesHandler,
) *RouterComponents {
	return &RouterComponents{
		components_sv: components,
	}
}

func (r *RouterComponents) RouterComponents(cp *gin.RouterGroup) {
	components := cp.Group("services")
	{
		components.GET("", r.components_sv.GetServices)
	}
}
