#!/bin/bash

source "$(dirname "$0")/containers.sh"

BASE_DIR="$(pwd)"
BUILD_MODE=false

if [[ "$1" == "build" ]]; then
  BUILD_MODE=true
  echo "Режим сборки: включен"
else
  echo "Режим сборки: выключен"
fi

start_project() {
  local project_dir="$1"
  
  if [ -f "$project_dir/docker-compose.yml" ]; then
    echo "Запускаем проект: $project_dir"
    if $BUILD_MODE; then
      (cd "$project_dir" && docker-compose up --build -d)
    else
      (cd "$project_dir" && docker-compose up -d)
    fi
  else
    echo "Файл docker-compose.yml не найден в $project_dir. Пропускаем."
  fi
}

for project in "${CONTAINERS[@]}"; do
  PROJECT_DIR="$BASE_DIR/$project"
  
  if [ -d "$PROJECT_DIR" ]; then
    start_project "$PROJECT_DIR"
  else
    echo "Папка $PROJECT_DIR не найдена. Пропускаем."
  fi
done

echo "Все проекты обработаны."
