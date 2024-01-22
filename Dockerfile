FROM ubuntu:22.04

# Update package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y nginx zip curl && \
    rm -rf /var/lib/apt/lists/*

# Append "daemon off;" to the nginx.conf file to keep Nginx running in the foreground
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Create a directory to store the downloaded files
WORKDIR /var/www/html

# Download the ZIP file from the GitHub repository
RUN curl -o main.zip -L https://github.com/tusharpawar9999/2048-Game---Docker-Project/archive/main.zip

# Unzip the downloaded file and move its contents to the current directory
RUN unzip main.zip && mv 2048-Game---Docker-Project-main/* . && rm -rf 2048-Game---Docker-Project-main main.zip

# Expose port 80 for Nginx
EXPOSE 80

# Start Nginx when the container runs
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
