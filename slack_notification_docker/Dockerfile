FROM node:latest

WORKDIR /usr/src/app

COPY package.json ./

RUN npm i

COPY . .

ENTRYPOINT ["node", "/usr/src/app/index.js"]
