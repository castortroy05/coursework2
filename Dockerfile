FROM node:current-slim
WORKDIR /usr/src/app
RUN npm install
EXPOSE 8080
COPY server.js .
CMD [ "node", "server.js" ]

