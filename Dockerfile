FROM node:12-alpine
WORKDIR /app
COPY ./package.json ./
COPY ./webpack.config.js ./
COPY ./public/ ./public/
COPY ./scripts/ ./scripts/
COPY ./src/ ./src/
RUN npm install
CMD npm run dev

