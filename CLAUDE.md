# rimple-default-collector

OpenTelemetry Collector configurations for various export targets, run via Docker Compose.

## Prerequisites

- Docker and Docker Compose
- A `.env` file in the project root (gitignored) containing:
  ```
  HONEYCOMB_API_KEY=<your-honeycomb-api-key>
  ```
- AWS credentials in `~/.aws` (for S3 export targets only)

## How the API Key Reaches the Collector

1. You place your `HONEYCOMB_API_KEY` in the `.env` file at the project root.
2. Both Docker Compose files (`docker-compose-honeycomb-collector.yaml` and `docker-compose-collector-contrib.yaml`) load it via `env_file: .env`.
3. Collector config files (e.g. `honeycomb-output-config.yaml`) reference it as `${HONEYCOMB_API_KEY}` in the exporter headers.

## Docker Compose Files

| File | Image | Notes |
|------|-------|-------|
| `docker-compose-honeycomb-collector.yaml` | `honeycombio/honeycomb-opentelemetry-collector:latest` | Honeycomb-specific collector with sourcemap support |
| `docker-compose-collector-contrib.yaml` | `otel/opentelemetry-collector-contrib:0.123.0` | Standard OTel contrib collector, mounts `~/.aws` for S3 |

## Makefile Targets

Each collector profile has three targets: `run-*` (start detached), `logs-*` (tail logs), `down-*` (stop).

### Honeycomb Collector (symbolicator)

Uses `docker-compose-honeycomb-collector.yaml` with the Honeycomb collector image.

| Target | Config | Description |
|--------|--------|-------------|
| `make run-symbolicator` | `symbolicator-config.yaml` | Start Honeycomb collector with symbolicator config |
| `make logs-symbolicator` | | Tail logs |
| `make down-symbolicator` | | Stop |

### OTel Contrib Collector

Uses `docker-compose-collector-contrib.yaml` with the standard contrib image.

| Target | Config | Description |
|--------|--------|-------------|
| `make run-contrib` | `console-output-config.yaml` | Console debug output |
| `make logs-contrib` | | Tail logs |
| `make down-contrib` | | Stop |
| `make run-honeycomb-contrib` | `honeycomb-output-config.yaml` | Export to Honeycomb via OTLP |
| `make logs-honeycomb-contrib` | | Tail logs |
| `make down-honeycomb-contrib` | | Stop |
| `make run-files-contrib` | `file-output-config.yaml` | Export to local files |
| `make logs-files-contrib` | | Tail logs |
| `make down-files-contrib` | | Stop |
| `make run-s3-contrib` | `s3-export-config.yaml` | Export to S3 |
| `make logs-s3-contrib` | | Tail logs |
| `make down-s3-contrib` | | Stop |
| `make run-s3-converter-contrib` | `s3-converter-config.yaml` | S3 format converter |
| `make logs-s3-converter-contrib` | | Tail logs |
| `make down-s3-converter-contrib` | | Stop |
| `make run-llm` | `s3-export-llm.yaml` | LLM-related S3 export |
| `make logs-llm` | | Tail logs |
| `make down-llm` | | Stop |

### Console Output (contrib collector)

Uses `docker-compose-collector-contrib.yaml`. Functionally identical to `run-contrib`.

| Target | Config | Description |
|--------|--------|-------------|
| `make run-console-output` | `console-output-config.yaml` | Start contrib collector with console output |
| `make logs-console-output` | | Tail logs |
| `make down-console-output` | | Stop |

### Utility Targets

| Target | Description |
|--------|-------------|
| `make stop` | Stop all services across both compose files |
| `make clean` | Stop and remove volumes across both compose files |

## Ports

All configurations expose:
- `4317` - OTLP gRPC receiver
- `4318` - OTLP HTTP receiver
