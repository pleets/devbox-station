build:
	docker compose build

start:
	docker compose up --detach

stop:
	docker compose stop

shell:
    # start a login shell with -l so that nvm is sourced
	docker exec -it -u appuser web_app /bin/bash -l

shell-root:
	docker exec -it web_app /bin/bash

refresh:
	docker compose up --detach --build --force-recreate

apache-restart:
	docker exec web_app "apachectl" "-k" "restart"

apache-status:
	docker exec web_app "apachectl" "status"

delete:
	docker compose down --remove-orphans
