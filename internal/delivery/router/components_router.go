package router

import (
	"github.com/gin-gonic/gin"
	"opengine.com/m/internal/delivery"
)

type RouterComponents struct {
	components_sv   *delivery.ServicesHandler
	components_rs   *delivery.ResourcesHandler
	account_c       *delivery.AccountCertHandler
	sub_resource_id *delivery.SubResourcesHandler
	test_case_id    *delivery.TestCaseHandler
}

func NewRouterComponents(
	components *delivery.ServicesHandler,
	components_rs *delivery.ResourcesHandler,
	account_cert *delivery.AccountCertHandler,
	sub_resource *delivery.SubResourcesHandler,
	test_case *delivery.TestCaseHandler,
) *RouterComponents {
	return &RouterComponents{
		components_sv:   components,
		components_rs:   components_rs,
		account_c:       account_cert,
		sub_resource_id: sub_resource,
		test_case_id:    test_case,
	}
}

func (r *RouterComponents) RouterComponents(cp *gin.RouterGroup) {
	components := cp.Group("services")
	{
		components.GET("", r.components_sv.GetServices)
	}

	resources := cp.Group("resources")
	{
		//resources.GET("", r.components_rs.GetResources)
		resources.GET("", r.components_rs.ResourcesByServices)
	}

	account_cert := cp.Group("account_cert")
	{
		account_cert.GET("", r.account_c.GetAccountCert)
	}

	sub_resource := cp.Group("subresources")
	{
		sub_resource.GET("", r.sub_resource_id.GetSubResources)
	}

	test_case := cp.Group("testcase")
	{
		test_case.GET("", r.test_case_id.TestCaseBySr)
	}
}
