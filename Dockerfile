FROM node:16-alpine

WORKDIR /usr/src/market-app

COPY . .

WORKDIR /usr/src/market-app/server

RUN npm install

EXPOSE 2024

CMD ["npm", "start"]
