FROM alpine

COPY . /app

RUN cd /app \
  && chmod +x *.sh \
  && ./install.sh