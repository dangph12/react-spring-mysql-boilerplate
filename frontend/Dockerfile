# syntax=docker/dockerfile:1.4

FROM --platform=$BUILDPLATFORM node:22-bookworm-slim AS development

WORKDIR /code
COPY package.json /code/package.json
COPY package-lock.json /code/package-lock.json

RUN npm ci
COPY . /code

COPY choose-env.sh /usr/local/bin/choose-env.sh

FROM development AS build

ARG NODE_ENV

RUN chmod +x /usr/local/bin/choose-env.sh && /usr/local/bin/choose-env.sh

FROM nginx:1.27.3-alpine-slim

COPY --from=build /code/dist /usr/share/nginx/html

CMD ["nginx", "-g", "daemon off;"]