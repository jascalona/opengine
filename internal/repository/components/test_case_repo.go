package components

import "database/sql"

type TestCaseRepo struct {
	DB *sql.DB
}

func NewTestCaseRepo(db *sql.DB) {

}
