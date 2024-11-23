#!/bin/bash

BASE_DIR="$(pwd)"

PROJECTS=(
  "AdminConstructionAutomation"
  "ConstructionAutomationApi"
  "ConstructionAutomationFront"
  "ConstructionAutomation.ReportService"
  "errorLoggingConstruction"
)

stop_project() {
  local project_dir="$1"
  
  if [ -f "$project_dir/docker-compose.yml" ]; then
    echo "Останавливаем проект: $project_dir"
    (cd "$project_dir" && docker-compose down)
  else
    echo "Файл docker-compose.yml не найден в $project_dir. Пропускаем."
  fi
}

for project in "${PROJECTS[@]}"; do
  PROJECT_DIR="$BASE_DIR/$project"
  
  if [ -d "$PROJECT_DIR" ]; then
    stop_project "$PROJECT_DIR"
  else
    echo "Папка $PROJECT_DIR не найдена. Пропускаем."
  fi
done

echo "Все проекты остановлены."
