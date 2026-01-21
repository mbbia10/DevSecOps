FROM node:20-alpine

WORKDIR /app

RUN npm install -g npm@11.6.1

COPY app/package.json .
RUN npm install

CMD ["node"]
