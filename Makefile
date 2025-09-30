.PHONY: run-symbolicator logs-symbolicator run-console-output logs-console-output stop clean

run-symbolicator:
	CONFIG_FILE=./symbolicator-config.yaml docker compose -f docker-compose-honeycomb-collector.yaml up -d --build

logs-symbolicator:
	config_file=./symbolicator-config.yaml docker compose -f docker-compose-honeycomb-collector.yaml logs -f

down-symbolicator:
	config_file=./symbolicator-config.yaml docker compose -f docker-compose-honeycomb-collector.yaml down

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
	CONFIG_FILE=./console-output-config.yaml docker compose up -d --build

logs-console-output:
	CONFIG_FILE=./console-output-config.yaml docker compose logs -f

stop:
	docker compose down

clean:
	docker compose down -v