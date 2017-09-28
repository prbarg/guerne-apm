#FROM tomcat:8-jre7
FROM openshift/webserver30-tomcat8-openshift

MAINTAINER guenter.grossberger@ca.com

#ENV CATALINA_HOME=/home/jboos \
#ENV WILY_HOME=$CATALINA_HOME/wily \
ENV WILY_HOME=/opt/produban \
    CATALINA_HOME=/opt/webserver \
    INTROSCOPE_VERSION=10.5.1.8 \
    EM_HOST=lxapmdesa01 \
    EM_PORT=5001 \
    AGENT_NAME="Docker Tomcat Agent" \
    AGENT_HOSTNAME="testapm" \
    HEAP=2048m \
    ENABLE_BROWSER_AGENT=true

#Create PRB structure
RUN mkdir -p /opt/produban && chmod -R 777 /opt/produban


# install agent
ADD IntroscopeAgentFiles-NoInstaller${INTROSCOPE_VERSION}tomcat.unix.tar $WILY_HOME 
#COPY IntroscopeAgentFiles-NoInstaller${INTROSCOPE_VERSION}tomcat.unix.tar $WILY_HOME
#RUN cd $WILY_HOME && tar -xf IntroscopeAgentFiles-NoInstaller${INTROSCOPE_VERSION}tomcat.unix.tar

# configure CA APM java agent
COPY setenv.sh $WILY_HOME/setenv.sh
RUN cat $WILY_HOME/setenv.sh >> $CATALINA_HOME/bin/setenv.sh \
    && chmod +x $CATALINA_HOME/bin/setenv.sh
