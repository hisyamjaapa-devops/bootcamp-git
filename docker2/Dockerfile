FROM node:20 AS build

WORKDIR /app

COPY package*.json ./

RUN npm clean-install

COPY . .

RUN npm run build


FROM nginx:alpine

COPY --from=build /app/dist /usr/share/nginx/html
COPY --from=build /app/dist /usr/share/nginx/html/devops-bootcamp-app

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
