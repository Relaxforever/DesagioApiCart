#!/bin/sh

# Esperar a que la base de datos esté lista
while ! nc -z $DB_HOST $DB_PORT; do
  echo "Esperando a que la base de datos esté lista..."
  sleep 1
done

echo "Base de datos lista, ejecutando migraciones..."

# Ejecutar migraciones
flask db upgrade

echo "Migraciones aplicadas, iniciando la aplicación..."

# Iniciar la aplicación
exec flask run --host=0.0.0.0
