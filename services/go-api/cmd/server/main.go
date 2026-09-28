package main

import (
	"encoding/json"
	"log"
	"net/http"
	"time"
)

type HealthResponse struct {
	Status string `json:"status"`
	Time   string `json:"time"`
}

func main() {
	mux := http.NewServeMux()
	mux.HandleFunc("GET /api/v1/health", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		_ = json.NewEncoder(w).Encode(HealthResponse{Status: "ok", Time: time.Now().UTC().Format(time.RFC3339)})
	})
	mux.HandleFunc("POST /api/v1/optimize", func(w http.ResponseWriter, r *http.Request) {
		http.Error(w, "Optimization endpoint is scaffolded; MiniZinc orchestration is Phase 4.", http.StatusNotImplemented)
	})
	mux.HandleFunc("POST /api/v1/scenarios", func(w http.ResponseWriter, r *http.Request) {
		http.Error(w, "Scenario endpoint is scaffolded; implementation is Phase 4.", http.StatusNotImplemented)
	})
	log.Println("EDI Morocco Water API listening on :8080")
	log.Fatal(http.ListenAndServe(":8080", mux))
}
