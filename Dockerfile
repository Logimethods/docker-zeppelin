FROM dylanmei/zeppelin:onbuild

ENV ZEPPELIN_MEM="-Xmx1024m"

COPY ./provided-libs $ZEPPELIN_HOME/provided-libs/
RUN ls $ZEPPELIN_HOME/provided-libs/

COPY ./provided-notebook $ZEPPELIN_HOME/provided-notebook/
RUN ls $ZEPPELIN_HOME/provided-notebook/

CMD cp -r $ZEPPELIN_HOME/provided-notebook/* $ZEPPELIN_HOME/notebook/ ; bin/zeppelin.sh 

