.env:
	@read -p "Enter remote host: " remote_host && \
	read -p "Enter remote port (22): " remote_port && \
	remote_port=$${remote_port:-22} && \
	read -p "Enter mysql user (root): " mysql_user && \
	mysql_user=$${mysql_user:-root} && \
	read -p "Enter mysql password: " mysql_password && \
	read -p "Enter local port for web interface (8080): " http_port && \
	http_port=$${http_port:-8080} && \
	echo "REMOTE_HOST=$${remote_host}\nREMOTE_PORT=$${remote_port}\nHTTP_PORT=$${http_port}\nPMA_USER=$${mysql_user}\nPMA_PASSWORD=$${mysql_password}" > .env

-include .env
export HTTP_PORT

.PHONY: start
start: .env
	@docker-compose up --build -d
	@echo "\n\033[1;32mphpmyadmin web interface available at: http://127.0.0.1:$$HTTP_PORT\033[0m"

.PHONY: stop
stop:
	@docker-compose down
	@rm .env
	@echo "\n\033[1;31mStopped\033[0m"
