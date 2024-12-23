ARG NODE_VERSION=20.14.0-alpine3.19

FROM node:${NODE_VERSION} as build
WORKDIR /app
COPY package* /app/
COPY . .

FROM build as dev
ENV HOST=0.0.0.0 PORT=3000 NODE_ENV=development
CMD ["npm", "run", "dev",]

FROM build as prod
EXPOSE 3000
ENV HOST=0.0.0.0 PORT=3000 NODE_ENV=production
RUN apk add --no-cache dumb-init \
    && rm -rf /tmp/*
RUN npm i --save-dev @types/nodemailer && npm install && npm run build
CMD ["dumb-init","node","./dist/server/entry.mjs"]
