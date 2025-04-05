.PHONY: run migrate makemigrations shell dbshell test clean build up down db web logs restart restart-web restart-db format lint

run:
	gunicorn --bind 0.0.0.0:8000 app_server.wsgi:application

migrate:
	python manage.py migrate

makemigrations:
	python manage.py makemigrations

shell:
	python manage.py shell

dbshell:
	python manage.py dbshell

test:
	python manage.py test

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

db:
	docker-compose up -d db

web:
	docker-compose up -d web

logs:
	docker-compose logs -f

restart:
	docker-compose restart

restart-web:
	docker-compose restart web

restart-db:
	docker-compose restart db

clean:
	find . -type d -name __pycache__ -exec rm -r {} +
	find . -type f -name "*.pyc" -delete
	find . -type f -name "*.pyo" -delete
	find . -type f -name "*.pyd" -delete

# Desarrollo
lint:
	pip install flake8
	flake8 .

format:
	pip install black
	black .

# Ayuda
help:
	@echo "Comandos disponibles:"
	@echo " run              - Ejecuta el servidor de desarrollo"
	@echo " migrate          - Aplica migraciones pendientes"
	@echo " makemigrations   - Crea nuevas migraciones"
	@echo " shell            - Inicia shell de Django"
	@echo " dbshell          - Inicia shell de base de datos"
	@echo " test             - Ejecuta tests"
	@echo " build            - Construye contenedores Docker"
	@echo " up               - Inicia servicios con Docker en modo desconectado"
	@echo " down             - Detiene servicios Docker"
	@echo " db               - Inicia solo la base de datos en modo desconectado"
	@echo " web              - Inicia solo el servicio web en modo desconectado"
	@echo " logs             - Muestra logs de los contenedores"
	@echo " restart          - Reinicia todos los servicios"
	@echo " restart-web      - Reinicia solo el servicio web"
	@echo " restart-db       - Reinicia solo el servicio de base de datos"
	@echo " clean            - Elimina archivos temporales"
	@echo " lint             - Ejecuta flake8 para verificar estilo"
	@echo " format           - Formatea código con black"
