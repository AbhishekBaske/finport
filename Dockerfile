##############################
#  FRONTEND BUILD STAGE
##############################
FROM node:20 AS frontend-build
WORKDIR /app/frontend

# Install dotenvx globally
RUN curl -sSf https://dotenvx.sh | bash -s -- install -b /usr/local/bin

COPY frontend/package*.json ./
RUN npm install

COPY frontend ./
RUN dotenvx run -- npm run build


##############################
#  BACKEND + RUNTIME STAGE
##############################
FROM node:20
WORKDIR /app

# Install dotenvx globally
RUN curl -sSf https://dotenvx.sh | bash -s -- install -b /usr/local/bin

# Install backend
COPY backend/package*.json ./
RUN npm install

COPY backend ./

# Copy frontend build output
COPY --from=frontend-build /app/frontend/dist ./public

# Install concurrently to run 2 servers
RUN npm install -g concurrently serve

# Expose ports
EXPOSE 3000 4000

# Start backend + frontend
CMD ["dotenvx", "run", "--", "concurrently", \
     "\"node index.js\"", \
     "\"serve -s public -l 4000\""]
