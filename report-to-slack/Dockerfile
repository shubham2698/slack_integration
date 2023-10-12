FROM node:latest
COPY package.json /app
COPY . /app
WORKDIR /app

RUN npm install

ENTRYPOINT ["node", "/app/index.js"]