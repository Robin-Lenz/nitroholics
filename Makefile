COMPOSE = docker compose

all: up

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

start:
	$(COMPOSE) start

stop:
	$(COMPOSE) stop

restart:
	$(COMPOSE) restart

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

clean:
	$(COMPOSE) down --remove-orphans

fclean:
	$(COMPOSE) down --remove-orphans
	sudo rm -rf data/mysql/*
	sudo rm -rf data/prestashop/*

re: fclean all

.PHONY: all up down start stop restart logs ps clean fclean re