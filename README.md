# titan-ccp-ksql

[![Build Status](https://travis-ci.org/j-grabitzky/titan-ccp-ksql.svg?branch=master)](https://travis-ci.org/j-grabitzky/titan-ccp-ksql)

# KSQL Server
connect the ksql service to your kafka cluster and make sure you are in the same docker network and that the ports match.

If you want to use the KSQL CLI go inside the container an call the command "ksql"
in the ksql cli use this command to connect to the right ksql server "server http://ksql-server:8088"
