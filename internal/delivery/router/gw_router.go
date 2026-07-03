package router

import (
	"github.com/gin-gonic/gin"
	delivery "opengine.com/m/internal/delivery/services/gw"
)

type RouterGW struct {
	gw_credit *delivery.InitCreditGwHandler
}

func NewRouterGW(
	credit *delivery.InitCreditGwHandler,
) *RouterGW {
	return &RouterGW{
		gw_credit: credit,
	}
}

func (r *RouterGW) TransactionCreditGW(rg *gin.RouterGroup) {
	gw_credit := rg.Group("credit")
	{
		gw_credit.POST("", r.gw_credit.InitCredit)
		gw_credit.GET("", r.gw_credit.ListCredit)
	}
}
