# Dockerfile for Frontend (React app)

# Use a Node.js image as base
FROM node:18.19.1-alpine

# Set working directory
WORKDIR /app

# Copy frontend files into the container
COPY ./package.json ./package-lock.json /app/
RUN npm install

# Copy the rest of the frontend files
COPY ./ /app/

# Build the React app
RUN npm run build

# Serve the app using nginx
FROM nginx:alpine

# Copy the build output to Nginx's public folder
COPY --from=0 /app/build /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx server
CMD ["nginx", "-g", "daemon off;"]
