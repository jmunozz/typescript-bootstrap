FROM node:12 AS builder

WORKDIR /app
COPY ./package* /app/
RUN npm ci
COPY src /app/src
RUN npm run build

FROM node:12-slim

WORKDIR /app
COPY --from=builder /app/build /app/build
COPY --from=builder /app/package.json /app/package.json
COPY --from=builder /app/node_modules /app/node_modules

CMD npm run start