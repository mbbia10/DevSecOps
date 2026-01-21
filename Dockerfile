FROM node:22-alpine

# Instala ferramentas de segurança (opcional, mas recomendado)
RUN apk add --no-cache tini

WORKDIR /app

# Copia apenas os arquivos de dependências primeiro (melhor cache)
COPY package.json package-lock.json ./

# Instala apenas dependências de produção e faz audit fix
RUN npm ci --only=production && \
    npm audit fix --only=production || true

# Copia o restante do código da aplicação
COPY . .

# Adiciona usuário não-root para segurança
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001 && \
    chown -R nodejs:nodejs /app
USER nodejs

# Usa tini como entrypoint para melhor tratamento de sinais
ENTRYPOINT ["/sbin/tini", "--"]

# Comando para rodar a aplicação
CMD ["node", "app/index.js"]  # Ajuste conforme seu ponto de entrada