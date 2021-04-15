FROM openjdk8:1.0

MAINTAINER Marty

ADD geoserver-2.16.2.tar /usr/local

ADD init.sh /usr/local/geoserver-2.16.2

ENV GEOSERVER_HOME /usr/local/geoserver-2.16.2

EXPOSE 8080

ENTRYPOINT ["sh","/usr/local/geoserver-2.16.2/bin/startup.sh"]

