build:
	docker compose build

start:
	docker compose up --detach

stop:
	docker compose stop

refresh:
	docker compose up --detach --build --force-recreate

delete:
	docker compose down --remove-orphans
