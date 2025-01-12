up:
	docker compose up -d

down:
	docker compose down --remove-orphans

restart:
	docker compose up --force-recreate --no-deps --build --remove-orphans -d


install-deps:
	docker exec throttle composer install

rollback-libphutil:
	docker exec -it throttle sh -c "cd /var/www/throttle/vendor/phacility/libphutil && git reset --hard 39ed96cd818aae761ec92613a9ba0800824d0ab0"

migrate:
	docker exec throttle php app/console.php migrations:migrate

folder-access:
	docker exec throttle chmod -R a+w logs cache dumps symbols/public

