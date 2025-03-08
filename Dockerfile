# Use the official Flutter image for building the app
FROM ghcr.io/cirruslabs/flutter:latest AS build

# Set the working directory in the container
WORKDIR /app

# Copy pubspec files first for caching dependencies
COPY pubspec.yaml pubspec.lock ./

# Get Flutter dependencies
RUN flutter pub get

# Copy the rest of the application
COPY . .

# Build the Flutter web app with environment variables
ARG API_BASE_URL
RUN flutter build web --release  --dart-define=API_BASE_URL=$API_BASE_URL

# Use Nginx to serve the Flutter web app
FROM nginx:alpine AS runtime

# Set the working directory to Nginx web root
WORKDIR /usr/share/nginx/html

# Remove default Nginx static assets
RUN rm -rf ./*

# Copy built Flutter web app
COPY --from=build /app/build/web ./

# Copy custom Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for web traffic
EXPOSE 80
RUN mv /usr/share/nginx/html/assets/assets/images /usr/share/nginx/html/assets/

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

