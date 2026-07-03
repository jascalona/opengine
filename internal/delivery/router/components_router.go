package router

import (
	"github.com/gin-gonic/gin"
	"opengine.com/m/internal/delivery"
)

type RouterComponents struct {
	components_sv *delivery.ServicesHandler
	components_rs *delivery.ResourcesHandler
}

func NewRouterComponents(
	components *delivery.ServicesHandler,
	components_rs *delivery.ResourcesHandler,
) *RouterComponents {
	return &RouterComponents{
		components_sv: components,
		components_rs: components_rs,
	}
}

func (r *RouterComponents) RouterComponents(cp *gin.RouterGroup) {
	components := cp.Group("services")
	{
		components.GET("", r.components_sv.GetServices)
	}

	resources := cp.Group("resources")
	{
		resources.GET("", r.components_rs.GetResources)
	}
}
