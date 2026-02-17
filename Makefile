.PHONY: run-symbolicator logs-symbolicator run-console-output logs-console-output stop clean

run-symbolicator:
	CONFIG_FILE=./symbolicator-config.yaml docker compose -f docker-compose-honeycomb-collector.yaml up -d --build

logs-symbolicator:
	CONFIG_FILE=./symbolicator-config.yaml docker compose -f docker-compose-honeycomb-collector.yaml logs -f

down-symbolicator:
	CONFIG_FILE=./symbolicator-config.yaml docker compose -f docker-compose-honeycomb-collector.yaml down

run-llm:
	CONFIG_FILE=./s3-export-llm.yaml docker compose -f docker-compose-collector-contrib.yaml up -d --build

logs-llm:
	CONFIG_FILE=./s3-export-llm.yaml docker compose -f docker-compose-collector-contrib.yaml logs -f

down-llm:
	CONFIG_FILE=./s3-export-llm.yaml docker compose -f docker-compose-collector-contrib.yaml down

run-contrib:
	CONFIG_FILE=./console-output-config.yaml docker compose -f docker-compose-collector-contrib.yaml up -d --build

logs-contrib:
	CONFIG_FILE=./console-output-config.yaml docker compose -f docker-compose-collector-contrib.yaml logs -f

down-contrib:
	CONFIG_FILE=./console-output-config.yaml docker compose -f docker-compose-collector-contrib.yaml down

run-honeycomb-contrib:
	CONFIG_FILE=./honeycomb-output-config.yaml docker compose -f docker-compose-collector-contrib.yaml up -d --build

logs-honeycomb-contrib:
	CONFIG_FILE=./honeycomb-output-config.yaml docker compose -f docker-compose-collector-contrib.yaml logs -f

down-honeycomb-contrib:
	CONFIG_FILE=./honeycomb-output-config.yaml docker compose -f docker-compose-collector-contrib.yaml down

run-console-output:
	CONFIG_FILE=./console-output-config.yaml docker compose -f docker-compose-collector-contrib.yaml up -d --build

logs-console-output:
	CONFIG_FILE=./console-output-config.yaml docker compose -f docker-compose-collector-contrib.yaml logs -f

down-console-output:
	CONFIG_FILE=./console-output-config.yaml docker compose -f docker-compose-collector-contrib.yaml down

down-files-contrib:
	CONFIG_FILE=./file-output-config.yaml docker compose -f docker-compose-collector-contrib.yaml down

run-files-contrib:
	CONFIG_FILE=./file-output-config.yaml docker compose -f docker-compose-collector-contrib.yaml up -d --build

logs-files-contrib:
	CONFIG_FILE=./file-output-config.yaml docker compose -f docker-compose-collector-contrib.yaml logs -f

down-s3-contrib:
	CONFIG_FILE=./s3-export-config.yaml docker compose -f docker-compose-collector-contrib.yaml down

run-s3-contrib:
	CONFIG_FILE=./s3-export-config.yaml docker compose -f docker-compose-collector-contrib.yaml up -d --build

logs-s3-contrib:
	CONFIG_FILE=./s3-export-config.yaml docker compose -f docker-compose-collector-contrib.yaml logs -f

down-s3-converter-contrib:
	CONFIG_FILE=./s3-converter-config.yaml docker compose -f docker-compose-collector-contrib.yaml down

run-s3-converter-contrib:
	CONFIG_FILE=./s3-converter-config.yaml docker compose -f docker-compose-collector-contrib.yaml up -d --build

logs-s3-converter-contrib:
	CONFIG_FILE=./s3-converter-config.yaml docker compose -f docker-compose-collector-contrib.yaml logs -f

stop:
	-docker compose -f docker-compose-collector-contrib.yaml down
	-docker compose -f docker-compose-honeycomb-collector.yaml down

clean:
	-docker compose -f docker-compose-collector-contrib.yaml down -v
	-docker compose -f docker-compose-honeycomb-collector.yaml down -v
