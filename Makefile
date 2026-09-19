.PHONY: bootstrap up down logs api test fmt

bootstrap:
	cp -n .env.example .env || true
	docker compose pull

up:
	docker compose up --build

down:
	docker compose down

logs:
	docker compose logs -f api

api:
	cd backend && python -m uvicorn app.main:app --reload --port 8000

test:
	cd backend && python -m pytest -q

fmt:
	cd backend && ruff check --fix app tests
