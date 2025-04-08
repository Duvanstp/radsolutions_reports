.PHONY: run migrate makemigrations test clean build up down db web logs restart restart-web restart-db format lint docker-migrate docker-makemigrations docker-createsuperuser setup

run:
	gunicorn --bind 0.0.0.0:8000 app_server.wsgi:application

migrate:
	python manage.py migrate

makemigrations:
	python manage.py makemigrations

test:
	python manage.py test

up:
	docker-compose up -d

down:
	docker-compose down

docker-createsuperuser:
	docker-compose exec web python manage.py createsuperuser

setup: up docker-makemigrations docker-migrate
	@echo "Sistema iniciado y configurado correctamente."
	@echo "Para crear un superusuario, ejecuta: make docker-createsuperuser"

lint:
	flake8 .
	isort . --check --profile black

format:
	black .
	isort .
	flake8 .
