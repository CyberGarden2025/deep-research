# One-command helpers for Local Deep Research with external OpenAI-compatible gateway

COMPOSE ?= docker compose
SERVICES := local-deep-research searxng

# Defaults align with docker-compose.override.yml
LDR_LLM_MODEL ?= gpt-oss:20b
LDR_LLM_OPENAI_ENDPOINT_URL ?= http://host.docker.internal:18080/v1
LDR_LLM_OPENAI_ENDPOINT_API_KEY ?= local-dev-no-key
LDR_HOST_PORT ?= 5731

.PHONY: up down restart logs

up:
	@PORT=$${LDR_HOST_PORT:-5731}; \
	echo "Starting: $(SERVICES) on host port $$PORT"; \
	LDR_LLM_MODEL=$(LDR_LLM_MODEL) \
	LDR_LLM_OPENAI_ENDPOINT_URL=$(LDR_LLM_OPENAI_ENDPOINT_URL) \
	LDR_LLM_OPENAI_ENDPOINT_API_KEY=$(LDR_LLM_OPENAI_ENDPOINT_API_KEY) \
	LDR_HOST_PORT=$$PORT \
	$(COMPOSE) up -d $(SERVICES)

down:
	$(COMPOSE) down

restart: down up

logs:
	$(COMPOSE) logs -f $(SERVICES)
