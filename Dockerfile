FROM node:18-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
ARG VITE_APP_DATA
ENV VITE_APP_DATA=${VITE_APP_DATA}
RUN npm run build
FROM nginx:alpine AS production
WORKDIR /usr/share/nginx/html
COPY --from=build /app/dist .
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
