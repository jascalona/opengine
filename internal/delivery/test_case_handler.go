package delivery

import (
	"net/http"
	"strconv"

	"github.com/gin-gonic/gin"
	"opengine.com/m/internal/serv/components"
)

type TestCaseHandler struct {
	Service components.TestCaseServ
}

func NewTestCaseHandler(s components.TestCaseServ) *TestCaseHandler {
	return &TestCaseHandler{Service: s}
}

func (h *TestCaseHandler) TestCaseBySr(c *gin.Context) {

	idStr := c.Query("sr_id")
	subId, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"Error: ": "El ID deve ser un numero valido"})
		return
	}

	list_test_case, err := h.Service.TestCaseBySr(c.Request.Context(), subId)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"Error interno: ": err.Error()})
		return
	}

	c.JSON(http.StatusOK, list_test_case)
}
