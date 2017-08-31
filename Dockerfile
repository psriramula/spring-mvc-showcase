FROM java:8-jre
#https://github.com/docker-library/tomcat

# set maintainer
LABEL maintainer "psriramula@icloud.com"

#CMD echo $target-env

ENV CATALINA_HOME /usr/local/tomcat
ENV PATH $CATALINA_HOME/bin:$PATH

RUN mkdir -p "$CATALINA_HOME"

WORKDIR $CATALINA_HOME

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.0.46
ENV TOMCAT_TGZ_URL https://www.apache.org/dist/tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz
ENV APP_CONFIG_URL https://raw.githubusercontent.com/psriramula/cd-poc-app-config-dev/master/spring-mvc-showcase/message.properties

RUN set -x \
    && curl -fSL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz \
    && tar -xvf tomcat.tar.gz --strip-components=1 \
    && curl -fSL "$APP_CONFIG_URL" -o $CATALINA_HOME/lib/message.properties \
    && rm bin/*.bat \
    && rm tomcat.tar.gz*

ADD ./target/*.war $CATALINA_HOME/webapps/
# assuming properties are configured in maven properties with classpath:*.properties
#ADD ./config/*.propertie $CATALINA_HOME/lib/

EXPOSE 8080
CMD ["catalina.sh", "run"]

# set a health check
HEALTHCHECK --interval=5s \
            --timeout=5s \
            CMD curl -f http://localhost:8080 || exit 1