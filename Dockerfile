FROM alpine

COPY . /app

RUN cd /app \
  && ./install.sh