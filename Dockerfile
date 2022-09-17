### Stage 1: Build
FROM node:14 AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build --prod

### Stage 2: Run
FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist/hello-docker-angular /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]
