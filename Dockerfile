FROM debian:jessie
RUN apt-get update \
  && apt-get install -y ca-certificates curl gcc make gettext-base \
          libxslt1-dev libpcre3-dev zlib1g-dev libssl-dev libgeoip-dev \
  && curl -fSL "http://nginx.org/download/nginx-1.11.8.tar.gz" -o /usr/src/nginx-1.11.8.tar.gz \
  && tar zxvf /usr/src/nginx-1.11.8.tar.gz -C /usr/src/ \
  && cd /usr/src/nginx-1.11.8 \
  && ./configure --prefix=/opt/nginx \
                  --with-http_stub_status_module \
                  --with-http_realip_module \
                  --with-http_ssl_module \
                  --with-http_geoip_module \
                  --with-http_xslt_module \
                  --with-http_perl_module \
                  --with-http_v2_module \
  && make install && rm -rf /usr/src/nginx-1.11.8* \
  && rm -rf /var/lib/apt/lists/*
  
EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
