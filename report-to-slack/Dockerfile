FROM node:latest

COPY . /app
WORKDIR /app
COPY package.json ./
RUN npm install

ENTRYPOINT ["node", "/app/index.js"]