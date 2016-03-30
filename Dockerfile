FROM dylanmei/zeppelin:onbuild

ENV ZEPPELIN_MEM="-Xmx1024m"

COPY ./libs/*.jar $ZEPPELIN_HOME/libs
COPY ./notebook/* $ZEPPELIN_HOME/notebook