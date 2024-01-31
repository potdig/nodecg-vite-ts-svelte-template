# Install NodeCG
FROM node:lts-alpine AS nodecg
WORKDIR /app
RUN apk --no-cache add git &&\
    git clone https://github.com/nodecg/nodecg.git &&\
    cd nodecg &&\
    npm install &&\
    npm run build

# Build apps
FROM node:lts-alpine AS build_app
WORKDIR /build
COPY . ./
RUN apk add --no-cache python3 alpine-sdk &&\
    npm install &&\
    npm run build &&\
    npm run build:extension

# Build for NodeCG bundle
FROM node:lts-alpine AS nodecg_modules
WORKDIR /build
COPY package-nodecg.json ./package.json
RUN apk add --no-cache python3 alpine-sdk &&\
    npm install

# Set up base of NodeCG
FROM node:lts-alpine AS base
ARG LAYOUTS_NAME
RUN apk --no-cache add vim
WORKDIR /app
COPY --from=nodecg /app/nodecg ./nodecg
WORKDIR /app/nodecg
EXPOSE 9090
CMD ["node", "index.js"]

# Build bundle
FROM base AS bundle
ARG LAYOUTS_NAME
WORKDIR /app/nodecg
COPY --from=build_app /build/dist ./bundles/${LAYOUTS_NAME}
COPY --from=nodecg_modules /build ./bundles/${LAYOUTS_NAME}
COPY ./cfg ./cfg
