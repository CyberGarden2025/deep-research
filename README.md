# Local Deep Research (owner: LearningCircuit)

This note covers only the Docker setup that uses an external OpenAI-compatible gateway on the host (example: `http://host.docker.internal:18080/v1`).  
Edits applied by Artem-Darius Weber.

## How to run

```bash
cd /Users/darius/Downloads/seep-res/local-deep-research
# Start app + searxng, use external gateway on host port 18080
LDR_LLM_OPENAI_ENDPOINT_API_KEY=<key-if-required> docker compose up -d local-deep-research searxng
```

- Base URL is pinned via `docker-compose.override.yml` to `http://host.docker.internal:18080/v1`.
- Default model: `gpt-oss:20b`. Override with `LDR_LLM_MODEL=<your-model>`.
- If the gateway is open, leave `LDR_LLM_OPENAI_ENDPOINT_API_KEY` unset (fallback: `local-dev-no-key`).
- `extra_hosts` is set so the container can reach the host on Linux/macOS.
- Need the bundled Ollama too? Add it to the command: `... up -d local-deep-research searxng ollama`.

After startup, open `http://localhost:5000/settings` and confirm provider is **Custom OpenAI Endpoint** with your base URL/model.
