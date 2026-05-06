# Step 1: Use an official PHP image with Apache
FROM php:7.4-apache

# Step 2: Copy the application code from your repo into the web server folder
# The 'projCert' repo has code in the root, so we copy everything to /var/www/html/
COPY . /var/www/html/

# Step 3: Fix permissions so Apache can read the files
# This gives ownership to the web user and sets read/execute permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

# Step 3: Tell Docker to listen on port 80 (standard web port)
EXPOSE 80

# Step 4: Start Apache in the foreground
CMD ["apache2-foreground"]
