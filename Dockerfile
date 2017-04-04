FROM ubuntu:14.04
MAINTAINER asdaru

RUN locale-gen en_US ru_RU ru_RU.UTF-8
ENV LANG ru_RU.utf8

ENV DIST deb64_82_19_83.tar.gz 

RUN apt-get update && apt-get install -y \
	nano krb5-user libgssapi-krb5-2 unixodbc libgsf-bin t1utils libmagickwand-dev imagemagick wget

RUN ln -s /usr/lib/x86_64-linux-gnu/libMagickWand.so.5 /lib/libWand.so
RUN ln -s /usr/lib/x86_64-linux-gnu/libgssapi_krb5.so.2.2 /usr/lib/libgssapi_krb5.so

ENV SRV1CV8_DATA /opt/1C/data/
ENV NH_SERVER_ADDR "168.192.0.9 , 192.168.0.5" 

RUN mkdir /opt/dist && cd /opt/dist/ \
	&& wget http://casa.ru/${DIST} \
	&& tar xzf ${DIST} && dpkg -i *.deb
RUN mkdir -p /var/log/1c/dumps && chmod -R 777 /var/log/1c

RUN mkdir ${SRV1CV8_DATA}
RUN chown usr1cv82:grp1cv82 ${SRV1CV8_DATA}

COPY conf/nethasp.ini /opt/1C/v8.2/x86_64/conf/

#Расскомментировать для отладки
# COPY conf/logcfg.xml /opt/1C/v8.2/x86_64/conf/

RUN sed -i -e 's/^.\+default_tkt_enctypes.\+$/default_tkt_enctypes = rc4-hmac/' /etc/krb5.conf 
RUN sed -i -e 's/^.\+default_tgs_enctypes.\+$/default_tgs_enctypes = rc4-hmac/' /etc/krb5.conf 

COPY start_1c.sh /
RUN chmod +x /start_1c.sh

EXPOSE 1500-1599
VOLUME ${SRV1CV8_DATA}

#EXPOSE 1541
CMD ["/start_1c.sh"]
