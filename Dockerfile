# Use nginx to serve the static files
FROM nginx:stable-alpine

# Copy the build output to the nginx html directory
COPY ./build /usr/share/nginx/html/

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 to the outside world
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]

