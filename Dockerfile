FROM node:16-alpine AS build

WORKDIR /app

COPY flightmanager-app/package.json flightmanager-app/package-lock.json ./

RUN npm install

COPY flightmanager-app ./

RUN npm run build

FROM nginx:alpine

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
