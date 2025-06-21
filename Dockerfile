FROM node:16-alpine

COPY server /usr/src/market-app/server

WORKDIR /usr/src/market-app/server

RUN npm install

EXPOSE 2024

ENTRYPOINT ["npm", "start"]
