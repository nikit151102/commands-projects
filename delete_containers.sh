#!/bin/bash

CONTAINERS=(
  "telegram-log-service"
  "constructionautomationreportservice-report_service-1"
  "constructionautomationapi-backend-1"
  "telegram-log-service"
)

stop_and_remove_container() {
  local container_name="$1"
  
  if docker ps -a --format '{{.Names}}' | grep -q "$container_name"; then
    echo "Останавливаем и удаляем контейнер: $container_name"
    docker stop "$container_name"
    docker rm "$container_name"
  else
    echo "Контейнер с именем $container_name не найден. Пропускаем."
  fi
}

for container in "${CONTAINERS[@]}"; do
  stop_and_remove_container "$container"
done

echo "Все контейнеры обработаны."
