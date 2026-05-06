FROM php:7.4-apache

# 1. Clean the directory to ensure no old files remain
RUN rm -rf /var/www/html/*

# 2. Copy the CONTENTS of the website folder to the root
COPY website/ /var/www/html/

# 3. Fix permissions
RUN chown -R www-data:www-data /var/www/html && \
    chmod -R 755 /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
