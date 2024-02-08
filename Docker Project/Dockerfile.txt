#Build phase
FROM node:18-alpine as bulider
WORKDIR /usr/app
COPY ./package.json ./
RUN npm install
COPY . .
RUN npm run build

#Run Phase
FROM node:18-alpine
WORKDIR /usr/app
COPY ./package.json ./
RUN npm install
COPY --from=bulider /usr/app/dist ./
CMD ["node", "server.js"]