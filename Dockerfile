FROM node:20-alpine AS development

WORKDIR /app

# Install development tools
RUN apk add --no-cache bash curl wget

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy source code (when not using volumes)
COPY . .

# Expose Next.js port
EXPOSE 3000

# Development mode with hot-reloading (for development)
CMD ["npm", "run", "dev"]

# Build stage
FROM development AS build

# Build the Next.js application
RUN npm run build

# Production stage
FROM node:20-alpine AS production

WORKDIR /app

ENV NODE_ENV=production

# Copy package files
COPY package*.json ./

# Install only production dependencies
RUN npm ci --only=production

# Copy built application from build stage
COPY --from=build /app/.next ./.next
COPY --from=build /app/public ./public
COPY --from=build /app/next.config.js ./

# Expose Next.js port
EXPOSE 3000

# Start the application
CMD ["npm", "run", "start"]
