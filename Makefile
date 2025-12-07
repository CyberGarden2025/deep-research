# One-command helpers for Local Deep Research with external OpenAI-compatible gateway

COMPOSE ?= docker compose
SERVICES := local-deep-research searxng

# Set OLLAMA=1 to also start the bundled Ollama service
ifdef OLLAMA
SERVICES += ollama
endif

# Defaults align with docker-compose.override.yml
LDR_LLM_MODEL ?= gpt-oss:20b
LDR_LLM_OPENAI_ENDPOINT_URL ?= http://host.docker.internal:18080/v1
LDR_LLM_OPENAI_ENDPOINT_API_KEY ?= local-dev-no-key

.PHONY: up down restart logs

up:
	@echo "Starting: $(SERVICES)"
	LDR_LLM_MODEL=$(LDR_LLM_MODEL) \
	LDR_LLM_OPENAI_ENDPOINT_URL=$(LDR_LLM_OPENAI_ENDPOINT_URL) \
	LDR_LLM_OPENAI_ENDPOINT_API_KEY=$(LDR_LLM_OPENAI_ENDPOINT_API_KEY) \
	$(COMPOSE) up -d $(SERVICES)

down:
	$(COMPOSE) down

restart: down up

logs:
	$(COMPOSE) logs -f $(SERVICES)
