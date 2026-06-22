package router

import "github.com/gin-gonic/gin"

type MainRouter struct {
	RouterGW *RouterGW
}

func SetupRouter(r *gin.Engine, routers MainRouter) {

	api_v1 := r.Group("/api/v1")
	{
		routers.RouterGW.TransactionCreditGW(api_v1.Group("/transaction"))
	}
}
