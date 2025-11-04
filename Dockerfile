# ESTÁGIO 1 - BUILD
FROM node:18-alpine AS builder

WORKDIR /app

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# ESTÁGIO 2 - PRODUÇÃO
FROM node:18-alpine AS production

WORKDIR /app

COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./
# Copy static assets or config files if needed, for example:
# COPY --from=builder /app/public ./public
COPY --from=builder /app/dist ./dist

RUN npm install --only=production

CMD ["npm", "run", "start"]