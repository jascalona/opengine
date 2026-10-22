package router

import "github.com/gin-gonic/gin"

type MainRouter struct {
	RouterGW         *RouterGW
	RouterComponents *RouterComponents
}

func SetupRouter(r *gin.Engine, routers MainRouter) {

	api_v1 := r.Group("/api/v1")
	{
		routers.RouterGW.TransactionCreditGW(api_v1.Group("/transaction"))
		routers.RouterComponents.RouterComponents(api_v1.Group("/components"))
	}
}
