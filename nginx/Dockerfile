FROM ubuntu:14.04.4
MAINTAINER liulei "liulei@ct108.com" 

WORKDIR /usr/local/src/

RUN apt-get -qq update
RUN apt-get -qqy install apt-utils
RUN apt-get -qqy install git
RUN apt-get -qqy install curl
RUN apt-get -qqy install wget
RUN apt-get -qqy install unzip
RUN apt-get -qqy install git-core
RUN apt-get -qqy install build-essential
RUN apt-get -qqy install gcc
RUN apt-get -qqy install g++
RUN apt-get -qqy install cmake
RUN apt-get -qqy install gdb
RUN apt-get -qqy install libreadline-dev
RUN apt-get -qqy install groff
RUN apt-get -qqy install openssl
RUN apt-get -qqy install libssl-dev


#RUN curl -SL http://luajit.org/download/LuaJIT-2.0.4.tar.gz | tar -xz

COPY module/LuaJIT-2.0.4.tar.gz module/LuaJIT-2.0.4.tar.gz
RUN tar -xvf module/LuaJIT-2.0.4.tar.gz 
RUN  cd LuaJIT-2.0.4 && make && make install

RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/usr_local_lib.conf
RUN /sbin/ldconfig


#RUN curl -SL https://www.openssl.org/source/old/1.0.2/openssl-1.0.2g.tar.gz | tar -xz 
COPY module/openssl-1.0.2g.tar.gz module/openssl-1.0.2g.tar.gz
RUN tar -xvf module/openssl-1.0.2g.tar.gz

#RUN curl -SL http://exim.mirror.fr/pcre/pcre-8.37.tar.gz | tar -xz 
COPY module/pcre-8.37.tar.gz module/pcre-8.37.tar.gz
RUN tar -xvf module/pcre-8.37.tar.gz

#RUN curl -SL http://zlib.net/zlib-1.2.8.tar.gz | tar -xz 
COPY module/zlib-1.2.8.tar.gz module/zlib-1.2.8.tar.gz
RUN tar -xvf module/zlib-1.2.8.tar.gz

#RUN curl -SL http://people.freebsd.org/~osa/ngx_http_redis-0.3.8.tar.gz | tar -xz 
COPY module/ngx_http_redis-0.3.8.tar.gz module/ngx_http_redis-0.3.8.tar.gz
RUN tar -xvf module/ngx_http_redis-0.3.8.tar.gz

#RUN git clone https://github.com/openresty/echo-nginx-module.git
COPY module/echo-nginx-module.tar.gz module/echo-nginx-module.tar.gz
RUN tar -xvf module/echo-nginx-module.tar.gz

#RUN git clone https://github.com/simpl/ngx_devel_kit.git
COPY module/ngx_devel_kit.tar.gz module/ngx_devel_kit.tar.gz
RUN tar -xvf module/ngx_devel_kit.tar.gz

#RUN git clone https://github.com/openresty/redis2-nginx-module.git
COPY module/redis2-nginx-module.tar.gz module/redis2-nginx-module.tar.gz
RUN tar -xvf module/redis2-nginx-module.tar.gz

#RUN git clone https://github.com/openresty/srcache-nginx-module.git
COPY module/srcache-nginx-module.tar.gz module/srcache-nginx-module.tar.gz
RUN tar -xvf module/srcache-nginx-module.tar.gz

#RUN git clone https://github.com/openresty/lua-nginx-module.git
COPY module/lua-nginx-module.tar.gz module/lua-nginx-module.tar.gz
RUN tar -xvf module/lua-nginx-module.tar.gz

#RUN git clone https://github.com/openresty/set-misc-nginx-module.git
COPY module/set-misc-nginx-module.tar.gz module/set-misc-nginx-module.tar.gz
RUN tar -xvf module/set-misc-nginx-module.tar.gz

#RUN curl -SL http://nginx.org/download/nginx-1.8.1.tar.gz | tar -xz 
COPY module/nginx-1.8.1.tar.gz module/nginx-1.8.1.tar.gz
RUN tar -xvf module/nginx-1.8.1.tar.gz


RUN cd nginx-1.8.1 && \
	./configure  --prefix=/usr/local/nginx \
	--with-http_stub_status_module \
	--with-http_ssl_module \
	--with-pcre=../pcre-8.37 \
	--with-zlib=../zlib-1.2.8 \
	--with-openssl=../openssl-1.0.2g \
	--add-module=../echo-nginx-module \
	--add-module=../ngx_devel_kit \
	--add-module=../redis2-nginx-module \
	--add-module=../srcache-nginx-module \
	--add-module=../lua-nginx-module \
	--add-module=../ngx_http_redis-0.3.8 \
	--add-module=../set-misc-nginx-module  && \
	make && make install

COPY nginx.conf /usr/local/nginx/conf/nginx.conf
ADD vhost /usr/local/nginx/conf/vhost
ADD lua /usr/local/nginx/conf/lua
ADD tencentCA /usr/local/nginx/conf/tencentCA
ADD vlocation /usr/local/nginx/conf/vlocation
RUN mkdir -p /usr/local/nginx/temp/temp_dir
RUN mkdir -p /usr/local/nginx/temp/cache
RUN chmod 755 /usr/local/nginx/temp/

WORKDIR /usr/local/nginx/logs

EXPOSE 80 443

VOLUME ["/usr/local/nginx/logs/im","/usr/local/nginx/logs/allshuo","/usr/local/nginx/logs/cache","/usr/local/nginx/logs/all","/usr/local/nginx/logs/m"]


CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]