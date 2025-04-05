.PHONY: run migrate makemigrations test clean build up down db web logs restart restart-web restart-db format lint docker-migrate docker-makemigrations docker-createsuperuser setup

run:
	gunicorn --bind 0.0.0.0:8000 app_server.wsgi:application

migrate:
	python manage.py migrate

makemigrations:
	python manage.py makemigrations

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

# Comandos Docker para migraciones
docker-migrate:
	docker-compose exec web python manage.py migrate

docker-makemigrations:
	docker-compose exec web python manage.py makemigrations

# Crear superusuario
docker-createsuperuser:
	docker-compose exec web python manage.py createsuperuser

# Configuración completa del sistema
setup: build up docker-makemigrations docker-migrate
	@echo "Sistema iniciado y configurado correctamente."
	@echo "Para crear un superusuario, ejecuta: make docker-createsuperuser"

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
	@echo " docker-migrate   - Ejecuta migraciones dentro del contenedor Docker"
	@echo " docker-makemigrations - Crea migraciones dentro del contenedor Docker"
	@echo " docker-createsuperuser - Crea un superusuario dentro del contenedor Docker"
	@echo " setup            - Configura todo el sistema (build, up, migraciones)"
	@echo " lint             - Ejecuta flake8 para verificar estilo"
	@echo " format           - Formatea código con black"
