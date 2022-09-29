FROM public.ecr.aws/bitnami/openresty:1.21.4-1

WORKDIR /app

COPY ./www_files/ /var/www/

# Generate the keys
COPY tls/ /opt/bitnami/openresty/nginx/conf/tls/
ENV CERTS_PATH=/opt/bitnami/openresty/nginx/conf/tls
USER root
RUN openssl req -config ${CERTS_PATH}/certs_template.cnf \
  -new -x509 -sha256 -newkey rsa:2048 -nodes -keyout ${CERTS_PATH}/tests.key \
  -out ${CERTS_PATH}/tests.crt

COPY ./nginx.conf /opt/bitnami/openresty/nginx/conf/nginx.conf
