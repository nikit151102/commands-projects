#!/bin/bash

echo "Начинаем очистку Docker"

echo "Удаляем все неиспользуемые данные (контейнеры, образы, тома)"
docker system prune -a -f

EXCLUDED_VOLUME="backend_ucomand-database_data"
echo "Удаляем остановленные Docker-тома, исключая: $EXCLUDED_VOLUME"
docker volume ls -f dangling=true -q | grep -v "$EXCLUDED_VOLUME" | xargs -r docker volume rm

echo "Вывод статистики использования памяти (ext4 и xfs):"
df -h --type=ext4 --type=xfs

echo "Очистка завершена."
