FROM python:3.11-slim-buster

RUN mkdir /api-peliculas

WORKDIR /api-peliculas

RUN apt-get update
RUN apt-get install -y curl curl netcat

COPY . /api-peliculas

RUN pip3 install -r /api-peliculas/requirements.txt

ENV FLASK_APP "entrypoint:app"
ENV FLASK_ENV "development"
ENV APP_SETTINGS_MODULE "config.default"
ENV DATABASE_URL: "postgresql://postgres:root@db/ejemplo_api_peliculas"
ENV PORT 5001

#RUN flask db init
#RUN flask db stamp head
#RUN flask db revision --rev-id 0b7610f9fa78
#RUN flask db migrate
#RUN flask db upgrade

EXPOSE ${PORT}

# Copiar el script de entrada y dar permisos de ejecución
COPY entrypoint.sh /api-peliculas/entrypoint.sh
RUN chmod +x /api-peliculas/entrypoint.sh

# Usar el script de entrada como punto de entrada
ENTRYPOINT ["/api-peliculas/entrypoint.sh"]





#CMD ["flask","run","--host","0.0.0.0"]
