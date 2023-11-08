FROM python:3.11-slim-buster

RUN mkdir /api-peliculas

WORKDIR /api-peliculas

RUN apt-get update
RUN apt-get install -y curl

COPY . /api-peliculas

RUN pip3 install -r /api-peliculas/requirements.txt

ENV FLASK_APP "entrypoint:app"
ENV FLASK_ENV "development"
ENV APP_SETTINGS_MODULE "config.default"
ENV PORT 5001

RUN flask db init
#RUN flask db revision --rev-id 0b7610f9fa78
RUN flask db migrate
RUN flask db upgrade

EXPOSE ${PORT}

CMD ["flask","run","--host","0.0.0.0"]
