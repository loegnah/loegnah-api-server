FROM node:18-alpine AS builder
WORKDIR /app
COPY . .
RUN npm install -g pnpm && \
    pnpm install && \
    pnpm build

FROM node:18-alpine
WORKDIR /app
ENV NODE_ENV production
COPY --from=builder /app ./
RUN npm install -g pnpm
EXPOSE 3000
ENTRYPOINT ["pnpm","start:prod"]