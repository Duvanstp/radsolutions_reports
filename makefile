.PHONY: run migrate makemigrations test clean build up down db web logs restart restart-web restart-db format lint docker-migrate docker-makemigrations docker-createsuperuser docker-migrations docker-create-admin setup

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

docker-migrate:
	docker-compose exec web python manage.py migrate

docker-makemigrations:
	docker-compose exec web python manage.py makemigrations

docker-createsuperuser:
	docker-compose exec web python manage.py createsuperuser

docker-migrations:
	docker-compose exec web sh -c "python manage.py makemigrations && python manage.py migrate"

docker-create-admin:
	docker-compose exec web sh -c "echo \"from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@gmail.com', 'admin') if not User.objects.filter(username='admin').exists() else None\" | python manage.py shell"
	@echo "Superusuario 'admin' creado con contraseña 'admin' y correo 'admin@gmail.com'"

setup: up docker-migrations docker-create-admin
	@echo "Sistema iniciado y configurado correctamente."

lint:
	flake8 .
	isort . --check --profile black

format:
	black .
	isort .
	flake8 .
