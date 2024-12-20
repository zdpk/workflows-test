# FROM public.ecr.aws/nginx/nginx:1.27
FROM nginx:latest
# Copy custom configuration files if needed
# COPY ./nginx.conf /etc/nginx/nginx.conf

# Copy static website files if needed
COPY ./push.sh /usr/share/nginx/html

# Expose the default Nginx port
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

