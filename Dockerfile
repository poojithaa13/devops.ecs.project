# Base image
FROM node:20-slim

# Set working directory inside container
WORKDIR /app

# Copy package files first (layer caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy rest of the code
COPY . .

# Expose port
EXPOSE 3000

# Run the app
CMD ["node", "server.js"]
