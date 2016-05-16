FROM    ubuntu:14.04

RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes software-properties-common python-software-properties
RUN apt-add-repository -y ppa:webupd8team/java
RUN apt-get -y update
RUN /bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install oracle-java7-installer oracle-java7-set-default

ENV MAVEN_VERSION 3.3.1
RUN apt-get -y install curl
RUN curl -sSL http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven

RUN apt-get -y install git
RUN apt-get -y install npm
RUN git clone https://github.com/apache/incubator-zeppelin.git
# master branch, as of April 4, 2016 / https://github.com/apache/incubator-zeppelin/commit/b51af33cb1e74f337ee119f8a26f87989d86fcbc
RUN cd incubator-zeppelin \
	git reset --hard b51af33cb1e74f337ee119f8a26f87989d86fcbc

ADD warm_maven.sh /usr/local/bin/warm_maven.sh
ADD scripts/start-script.sh /start-script.sh
ADD scripts/configured_env.sh /configured_env.sh
RUN /usr/local/bin/warm_maven.sh 

# ZEPPELIN
ENV ZEPPELIN_HOME         /incubator-zeppelin

WORKDIR $ZEPPELIN_HOME

COPY ./libs $ZEPPELIN_HOME/provided-libs/
COPY ./notebook $ZEPPELIN_HOME/provided-notebook/

ENV ZEPPELIN_ALT         /zeppelin
RUN ln -s $ZEPPELIN_HOME $ZEPPELIN_ALT

VOLUME $ZEPPELIN_ALT/data
VOLUME $ZEPPELIN_ALT/notebook
VOLUME $ZEPPELIN_ALT/libs
#VOLUME $ZEPPELIN_ALT/conf

EXPOSE 9080 9081
RUN export ZEPPELIN_PORT=9080

#cp -r -u $ZEPPELIN_HOME/provided-conf/* $ZEPPELIN_HOME/conf/ ; 
CMD /start-script.sh