FROM node:16-alpine

COPY . /server/market-app

WORKDIR /server/market-app

RUN npm install

EXPOSE 2024

ENTRYPOINT ["npm", "start"]
