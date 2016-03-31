FROM epahomov/docker-zeppelin

# ZEPPELIN
ENV ZEPPELIN_HOME         /incubator-zeppelin

WORKDIR $ZEPPELIN_HOME

# master branch, as of March 31, 2016 / https://github.com/apache/incubator-zeppelin/commit/0ee791ce29b2c72b6c662d5e1e154fb8dde8c60e
RUN git pull; git reset --hard 0ee791ce29b2c72b6c662d5e1e154fb8dde8c60e
#git checkout branch-0.5.6
RUN mvn clean package -DskipTests -Pspark-1.6 -Dspark.version=1.6.1

COPY ./provided-libs $ZEPPELIN_HOME/provided-libs/
RUN ls $ZEPPELIN_HOME/provided-libs/

COPY ./provided-notebook $ZEPPELIN_HOME/provided-notebook/
RUN ls $ZEPPELIN_HOME/provided-notebook/

ENV ZEPPELIN_ALT         /zeppelin
RUN ln -s $ZEPPELIN_HOME $ZEPPELIN_ALT

VOLUME $ZEPPELIN_ALT/data
VOLUME $ZEPPELIN_ALT/notebook
VOLUME $ZEPPELIN_ALT/libs
#    - ./conf:/zeppelin/conf

CMD cp -r -u $ZEPPELIN_HOME/provided-notebook/* $ZEPPELIN_HOME/notebook/ ; cp -r -u $ZEPPELIN_HOME/provided-libs/* $ZEPPELIN_HOME/libs/ ; ./bin/zeppelin.sh start

