default: start
projname="ms-demo-golang"

.PHONY: start
start:
	docker-compose up -d

.PHONY: stop
stop:
	docker-compose down

.PHONY: logs
logs:
	docker-compose logs -f ${projname}

.PHONY: ps
ps:
	docker-compose ps

.PHONY: shell
shell:
	docker-compose exec ${projname} sh

.PHONY: build
build:
	docker-compose build --no-cache

.PHONY: dep-add
dep-add:
	docker-compose exec ${projname} scripts/env-jmp.sh dep ensure -add ${package}

.PHONY: dep-update
dep-update:
	docker-compose exec ${projname} scripts/env-jmp.sh dep ensure -update ${package}

.PHONY: dep-update-all
dep-update-all:
	docker-compose exec ${projname} scripts/env-jmp.sh dep ensure -update
