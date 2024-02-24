ACCOUNT_BINARY=accApp
ADMIN_BINARY=adminApp
AUTH_BINARY=authApp
BILLING_BINARY=billingApp
BILLING_SCHEDULER_BINARY=billScApp
COMPLIANCE_BINARY=complianceApp
NOTIFICATIONS_BINARY=notifyApp
STATISTICS_BINARY=statApp
USER_BINARY=userApp
WIDGET_BINARY=widgetApp
WIDGET_CONFIG_TASK_BINARY=widgetTaskApp
IMAGE_BINARY=imageApp
SITE_SCAN_TASK_APP=userSiteHistoryApp

## up_build: stops docker-compose (if running), builds all projects and starts docker compose
up_build: build_account_dev build_auth build_notifications_dev build_billing build_billing_scheduler build_statistics_dev build_compliance build_image_task_dev build_widget_dev build_conf_task_dev build_admin build_user_dev
	@echo "Stopping docker images (if running...)"
	docker-compose down
	@echo "Building (when required) and starting docker images..."
	docker-compose up --build -d
	@echo "Docker images built and started!"

## up: starts all containers in the background without forcing build
up:
	@echo "Starting Docker images..."
	docker-compose up -d
	@echo "Docker images started!"

## down: stop docker compose
down:
	@echo "Stopping docker compose..."
	docker-compose down
	@echo "Done!"


## build_admin: builds the admin panel task services binary as a linux executable
build_admin:
	@echo "Building admin binary..."
	cd ../admin_panel_task_service && env GOOS=linux CGO_ENABLED=0 go build -o ${ADMIN_BINARY} .
	@echo "Done!"

## up_build_admin: stops docker-compose (if running), builds all projects and starts docker compose
up_build_admin: build_admin
	@echo "Stopping docker images (if running...)"
	docker-compose down
	@echo "Building (when required) and starting docker images..."
	docker-compose up --build -d
	@echo "Docker images built and started!"

## build_compliance: builds the compliance service binary as a linux executable
build_compliance:
	@echo "Building compliance service binary..."
	cd ../compliance_test_entity_service && env GOOS=linux CGO_ENABLED=0 go build -o ${COMPLIANCE_BINARY} .
	@echo "Done!"

## up_build_compliance: stops docker-compose (if running), builds all projects and starts docker compose
up_build_compliance: build_compliance
	@echo "Stopping docker images (if running...)"
	docker-compose down
	@echo "Building (when required) and starting docker images..."
	docker-compose up --build -d
	@echo "Docker images built and started!"
	
## build_billing: builds the billing entity service binary as a linux executable
build_billing:
	@echo "Building billing binary..."
	cd ../billing_entity_service && env GOOS=linux CGO_ENABLED=0 go build -o ${BILLING_BINARY} .
	@echo "Done!"

## up_build: stops docker-compose (if running), builds all projects and starts docker compose
up_build_billing: build_billing
	@echo "Stopping docker images (if running...)"
	docker-compose down
	@echo "Building (when required) and starting docker images..."
	docker-compose up --build -d
	@echo "Docker images built and started!"

## build_auth: builds the auth binary as a linux executable
build_auth:
	@echo "Building auth binary..."
	cd ../auth_service && env GOOS=linux CGO_ENABLED=0 go build -o ${AUTH_BINARY} .
	@echo "Done!"

## stop: stop the auth entity
stop_auth:
	@echo "Stopping auth entity service..."
	@-pkill -SIGTERM -f "./${AUTH_BINARY}"
	@echo "Stopped auth entity service!"

## build_billing_scheduler: builds the billing scheduler task service binary as a linux executable
build_billing_scheduler:
	@echo "Building billing scheduler binary..."
	cd ../billing_scheduler_task_service && env GOOS=linux CGO_ENABLED=0 go build -o ${BILLING_SCHEDULER_BINARY} .
	@echo "Done!"

## stop: stop the billing_scheduler service
stop_billing_scheduler:
	@echo "Stopping billing_scheduler service..."
	@-pkill -SIGTERM -f "./${BILLING_SCHEDULER_BINARY}"
	@echo "Stopped billing_scheduler service!"

## build_account_dev: builds the account entity service binary
build_account_dev:
	@echo "Building account entity service binary..."
	cd ../account_entity_service && env CGO_ENABLED=0 go build -o ${ACCOUNT_BINARY} .
	@echo "Done!"

## stop: stop the account entity
stop_account:
	@echo "Stopping account entity service..."
	@-pkill -SIGTERM -f "./${ACCOUNT_BINARY}"
	@echo "Stopped account entity service!"

## build_notifications_dev: builds the notifications entity service binary
build_notifications_dev:
	@echo "Building notifications service binary..."
	cd ../notifications_entity_service && env CGO_ENABLED=0 go build -o ${NOTIFICATIONS_BINARY} .
	@echo "Done!"

## stop: stop the notification entity
stop_notification:
	@echo "Stopping notification entity service..."
	@-pkill -SIGTERM -f "./${NOTIFICATIONS_BINARY}"
	@echo "Stopped notification entity service!"

## build_statistics_dev: builds the statistics entity service binary
build_statistics_dev:
	@echo "Building statistics service binary..."
	cd ../statistics_entity_service && env CGO_ENABLED=0 go build -o ${STATISTICS_BINARY} .
	@echo "Done!"

## stop: stop the statistics entity
stop_statistics:
	@echo "Stopping statistics entity service..."
	@-pkill -SIGTERM -f "./${STATISTICS_BINARY}"
	@echo "Stopped statistics entity service!"

## build_user_dev: builds the user panel entity service binary
build_user_dev:
	@echo "Building user panel service binary..."
	cd ../user_panel_task_service && env CGO_ENABLED=0 go build -o ${USER_BINARY} .
	@echo "Done!"

## up_build: stops docker-compose (if running), builds all projects and starts docker compose
up_build_user_dev: build_user_dev
	@echo "Stopping docker images (if running...)"
	docker-compose down
	@echo "Building (when required) and starting docker images..."
	docker-compose up --build -d
	@echo "Docker images built and started!"

## build_widget_dev: builds the widget entity service binary
build_widget_dev:
	@echo "Building widget entity service binary..."
	cd ../widget_config_entity_service && env CGO_ENABLED=0 go build -o ${WIDGET_BINARY} .
	@echo "Done!"

## stop: stop the widget_config service
stop_widget_config:
	@echo "Stopping widget config entity service..."
	@-pkill -SIGTERM -f "./${WIDGET_BINARY}"
	@echo "Stopped widget config entity service!"

## restart_conf_task_dev: restarts the widget config task service binary
restart_conf_task_dev: build_conf_task_dev
	@echo "restarting widget config task service binary..."
	docker stop widget-config-task-service
	docker start widget-config-task-service
	@echo "Done!"

## build_conf_task_dev: builds the widget config task service binary
build_conf_task_dev:
	@echo "Building widget config task service binary..."
	cd ../widget_config_task_service && env CGO_ENABLED=0 go build -o ${WIDGET_CONFIG_TASK_BINARY} .
	@echo "Done!"

## stop: stop the widget config task service
stop_widget_config_task:
	@echo "Stopping widget config task entity service..."
	@-pkill -SIGTERM -f "./${WIDGET_CONFIG_TASK_BINARY}"
	@echo "Stopped widget config task service!"

## build_image_task_dev: builds the image recognition task service binary
build_image_task_dev:
	@echo "Building image recognition task service binary..."
	cd ../image_recognition_entity_service && env CGO_ENABLED=0 go build -o ${IMAGE_BINARY} .
	@echo "Done!"

## stop: stop the image_task_dev entity
stop_image_task_dev:
	@echo "Stopping image_recognition_entity_service..."
	@-pkill -SIGTERM -f "./${IMAGE_BINARY}"
	@echo "Stopped image_recognition_entity_service!"

## start: starts the account entity service
start_image_task_dev: build_image_task_dev
	@echo "Starting front end"
	cd ../image_recognition_entity_service && ./${IMAGE_BINARY} &

## build_site_scan_task: builds the site scan task service binary
build_site_scan_task:
	@echo "Building image recognition task service binary..."
	cd ../user_site_history_service && env CGO_ENABLED=0 go build -o ${SITE_SCAN_TASK_APP} .
	@echo "Done!"

## start: starts the account entity service
start: build_account_dev
	@echo "Starting front end"
	cd ../account_entity_service && ./${ACCOUNT_BINARY} &

