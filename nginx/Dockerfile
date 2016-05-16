FROM ubuntu:14.04.4
MAINTAINER liulei "liulei@ct108.com" 

RUN cd /tmp 
RUN curl -L http://luajit.org/download/LuaJIT-2.0.4.tar.gz | tar -xz 
RUN make && make install

RUN curl -L https://www.openssl.org/source/old/1.0.2/openssl-1.0.2g.tar.gz | tar -xz 
RUN curl -L http://exim.mirror.fr/pcre/pcre-8.37.tar.gz | tar -xz 
RUN curl -L http://zlib.net/zlib-1.2.8.tar.gz | tar -xz 
RUN curl -L http://people.freebsd.org/~osa/ngx_http_redis-0.3.8.tar.gz | tar -xz 
RUN git clone https://github.com/openresty/echo-nginx-module.git
RUN git clone https://github.com/simpl/ngx_devel_kit.git
RUN git clone https://github.com/openresty/redis2-nginx-module.git
RUN git clone https://github.com/openresty/srcache-nginx-module.git
RUN git clone https://github.com/openresty/lua-nginx-module
RUN git clone https://github.com/openresty/set-misc-nginx-module.git

RUN curl -L http://nginx.org/download/nginx-1.8.1.tar.gz | tar -xz 

RUN cd nginx-1.8.1

RUN ./configure  --prefix=/usr/local/nginx --with-http_stub_status_module --with-http_ssl_module --with-pcre=../pcre-8.37 --with-zlib=../zlib-1.2.8 --with-openssl=../openssl-1.0.2e  --add-module=../echo-nginx-module --add-module=../ngx_devel_kit --add-module=../redis2-nginx-module --add-module=../srcache-nginx-module --add-module=../lua-nginx-module --add-module=../ngx_http_redis --add-module=../set-misc-nginx-module
RUN make && make install

EXPOSE 80
CMD ["/usr/local/nginx/sbin/nginx"]