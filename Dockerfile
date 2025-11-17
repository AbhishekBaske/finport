##############################
#  FRONTEND BUILD STAGE
##############################
FROM node:20 AS frontend-build
WORKDIR /app/frontend

COPY frontend/package*.json ./
RUN npm install

COPY frontend ./
RUN npm run build


##############################
#  BACKEND + RUNTIME STAGE
##############################
FROM node:20
WORKDIR /app

# Install backend dependencies
COPY backend/package*.json ./
RUN npm install

COPY backend ./

# Copy frontend build output
COPY --from=frontend-build /app/frontend/build ./public

# Install concurrently to run both servers
RUN npm install -g concurrently serve

EXPOSE 3000 4000

CMD ["concurrently", \
     "\"node index.js\"", \
     "\"serve -s public -l 4000\""]
