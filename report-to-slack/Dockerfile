FROM node:latest

WORKDIR /app
COPY . /app

RUN npm install @actions/core@1.2.4
RUN npm install axios

ENTRYPOINT ["node", "/app/index.js"]