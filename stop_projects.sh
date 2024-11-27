#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/containers.sh"

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
