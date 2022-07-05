## share this volume: /usr/local/stagingwebapps with docker run to automatically populate war
FROM tomcat:9.0
MAINTAINER Winter Soldier <sagarksuchi@gmail.com>
RUN mkdir /usr/local/scripts && \
    mkdir /usr/local/stagingwebapps
COPY wardeployer.sh /usr/local/scripts/wardeployer.sh
RUN sed -i 's/\r//' /usr/local/scripts/wardeployer.sh
COPY tomcat-users.xml /usr/local/tomcat/conf/tomcat-users.xml
COPY host-manager-context.xml /usr/local/tomcat/webapps/host-manager/META-INF/context.xml
COPY manager-context.xml /usr/local/tomcat/webapps/manager/META-INF/context.xml
RUN chmod -R 777 /usr/local/scripts && \
    chmod -R 777 /usr/local/stagingwebapps
ENV WEBAPPS_STAGING="/usr/local/stagingwebapps"
ENV PATH="/usr/local/tomcat/bin:/usr/local/scripts:${PATH}"
ENTRYPOINT ["bash", "/usr/local/scripts/wardeployer.sh"]
EXPOSE 8080