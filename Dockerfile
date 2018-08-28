FROM zenika/alpine-chrome:latest
MAINTAINER Magnet.me

EXPOSE 3000

USER root
RUN chromium-browser --no-sandbox --version > /opt/chromeVersion

RUN mkdir -p /usr/src/app
RUN adduser -D prerender && chown -R prerender:prerender /usr/src/app

USER prerender
WORKDIR /usr/src/app

COPY yarn.lock /usr/src/app/
COPY package.json /usr/src/app/
RUN yarn --pure-lockfile install
COPY . /usr/src/app

CMD [ "dumb-init", "yarn", "prod" ]
