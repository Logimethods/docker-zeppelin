# docker-zeppelin
Logimethods' Zeppelin on Docker

## To build the Cassandra Connector lib (spark-cassandra-connector-assembly-*.jar):

    github-mac://openRepo/https://github.com/datastax/spark-cassandra-connector
    
    >sbt assembly
    
The lib is then located in spark-cassandra-connector/target/[scala-2.10]/    
