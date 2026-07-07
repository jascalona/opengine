package main

import (
	"log"

	"github.com/gin-gonic/gin"
	"github.com/joho/godotenv"
	"opengine.com/m/cmd/config"
	cpDelivery "opengine.com/m/internal/delivery"
	"opengine.com/m/internal/delivery/router"
	delivery "opengine.com/m/internal/delivery/services/gw"

	cpRepo "opengine.com/m/internal/repository/components"
	repository "opengine.com/m/internal/repository/services/gw"

	AccountCertRepo "opengine.com/m/internal/repository/components/certification"

	cpServ "opengine.com/m/internal/serv/components"
	AccountCertServ "opengine.com/m/internal/serv/components/certification"
	serv "opengine.com/m/internal/serv/services/gw"
)

func main() {
	// Cargar variables de entorno desde el archivo .env
	if err := godotenv.Load(); err != nil {
		log.Println("Archivo .env no encontrado, usando variables de sistema.")
	}

	// Cargar configuración unificada (Env + appsetting.json) e inicializar DB
	cfg := config.LoadConfig()
	dbConn := config.InitDB(cfg.DatabaseURL)
	defer dbConn.Close()

	// =========================================================================
	// INYECCION DE DEPENDENCIAS: CAPA DE PERSISTENCIA (REPO)
	// =========================================================================
	gw_credit_repo := repository.NewRepoInitCreditGW(dbConn)

	// COMPONENTS
	services_repo := cpRepo.NewServicespRepo(dbConn)
	resources_repo := cpRepo.NewResourcesRepo(dbConn)
	sub_resource_repo := cpRepo.NewSubResourcesRepo(dbConn)

	account_cert_repo := AccountCertRepo.NewAccountCert(dbConn)

	test_case_repo := cpRepo.NewTestCaseRepo(dbConn)

	// =========================================================================
	// INYECCION DE DEPENDENCIAS: CAPA DE LOGICA DE NEGOCIO (SERV)
	// =========================================================================
	// Ahora le pasamos de forma segura el repositorio y el sub-bloque de configuración
	gw_credit_serv := serv.NewServInitCreditGW(
		gw_credit_repo,
		cfg.ExternalServices.CreditValidation,
	)

	// SERVICIOS COMPONENTS
	services_serv := cpServ.NewServicesServ(services_repo)
	resources_serv := cpServ.NewResourcesServ(resources_repo)
	sub_resource_serv := cpServ.NewSubRespurcesServ(sub_resource_repo)

	account_cert_serv := AccountCertServ.NewAccountCertServ(account_cert_repo)

	test_case_serv := cpServ.NewTestCaseServ(test_case_repo)

	// =========================================================================
	// INYECCION DE DEPENDENCIAS: CAPA DE ENTREGA (MANEJADOR HTTP)
	// =========================================================================
	gw_credit_handler := delivery.NewHandlerInitCreditGW(gw_credit_serv)

	// HANDLER COMPONENTS
	services_handler := cpDelivery.NewServicesHandler(services_serv)
	resources_handler := cpDelivery.NewResourcesHandler(resources_serv)
	sub_resource_handler := cpDelivery.NewSubResourcesHandler(sub_resource_serv)

	account_cert_handler := cpDelivery.NewAccountCert(account_cert_serv)

	test_case_handler := cpDelivery.NewTestCaseHandler(test_case_serv)
	// =========================================================================
	// INSTANCIACION DE ENRUTADORES MODULARES
	// =========================================================================
	gw_transaction := router.NewRouterGW(
		gw_credit_handler,
	)

	components_services := router.NewRouterComponents(
		services_handler,
		resources_handler,
		account_cert_handler,
		sub_resource_handler,
		test_case_handler,
	)

	apiRouter := router.MainRouter{
		RouterGW:         gw_transaction,
		RouterComponents: components_services,
	}

	// =========================================================================
	// INICIALIZACION DE GIN Y RUTAS CENTRALES
	// =========================================================================
	r := gin.Default()

	router.SetupRouter(r, apiRouter)

	// Ejecución del servidor
	port := ":8082"
	log.Printf("Servidor corriendo exitosamente en el puerto: %s", port)
	if err := r.Run(port); err != nil {
		log.Fatalf("Error crítico al iniciar el servidor: %v", err)
	}
}
