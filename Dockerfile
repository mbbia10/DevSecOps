FROM node:22-alpine

WORKDIR /app

RUN npm install -g npm@latest

COPY app/package.json .
RUN npm install

CMD ["node"]
