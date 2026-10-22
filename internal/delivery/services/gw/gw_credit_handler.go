package delivery

import (
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
	gw "opengine.com/m/internal/domain/services/gw"
	"opengine.com/m/internal/domain/utils"
	serv "opengine.com/m/internal/serv/services/gw"
)

type InitCreditGwHandler struct {
	Service serv.ServInitCreditGW
}

func NewHandlerInitCreditGW(s serv.ServInitCreditGW) *InitCreditGwHandler {
	return &InitCreditGwHandler{Service: s}
}

func (h *InitCreditGwHandler) ListCredit(c *gin.Context) {
	transactions, err := h.Service.ListCredit(c.Request.Context())
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"Error interno": err.Error()})
		return
	}
	c.JSON(http.StatusOK, transactions)

}

func (h *InitCreditGwHandler) InitCredit(c *gin.Context) {
	var reqCredit gw.ValidateServiceCredit

	if err := c.ShouldBindJSON(&reqCredit); err != nil {
		errors := utils.GetValidationError(err)

		if errors != nil {
			log.Println("error en la validacion del mensaje ", err.Error())
			c.JSON(http.StatusConflict, gin.H{"error de formato": errors})
			return
		}
		log.Println("Error en la deserializacion: ", err.Error())
		c.JSON(http.StatusBadRequest, gin.H{"error": "json mal formado"})
		return
	}

	toNullable := func(v string) *string {
		if v == "" {
			return nil
		}
		return &v
	}

	// validaciones de formato

	creditazo := gw.CreditTransaction{
		TraceId:                 reqCredit.TraceId,
		TransactionId:           reqCredit.TransactionId,
		UserId:                  reqCredit.UserId,
		UserReferenceId:         reqCredit.UserReferenceId,
		UserGroupId:             reqCredit.UserGroupId,
		UserUniqueId:            reqCredit.UserUniqueId,
		CreationDate:            toNullable(*reqCredit.CreationDate),
		SypagoInitDate:          toNullable(*reqCredit.SypagoInitDate),
		SypagoProcessDate:       toNullable(*reqCredit.SypagoProcessDate),
		Product:                 reqCredit.Product,
		SubProduct:              reqCredit.SubProduct,
		Amount:                  reqCredit.Amount,
		ProductSypago:           reqCredit.ProductSypago,
		SubProductSypago:        reqCredit.SubProductSypago,
		ApprovalAgent:           reqCredit.ApprovalAgent,
		SyPagoCreationChannel:   reqCredit.SyPagoCreationChannel,
		SyPagoAcceptanceChannel: reqCredit.SyPagoAcceptanceChannel,
		IssuingAgent:            reqCredit.IssuingAgent,
		IssuingUser:             reqCredit.IssuingUser,
		ReceivingAgent:          reqCredit.ReceivingAgent,
		ReceivingUser:           reqCredit.ReceivingUser,
		Status:                  reqCredit.Status,
		EndToEndId:              reqCredit.EndToEndId,
		RejectedCode:            reqCredit.RejectedCode,
	}

	err := h.Service.InitCredit(c.Request.Context(), &creditazo)
	if err != nil {
		log.Printf("[ERROR]: %v", &creditazo)
		c.JSON(http.StatusInternalServerError, gin.H{"error interno": err.Error()})
		return
	}

	c.JSON(http.StatusCreated, "Solicitud procesada")

}
