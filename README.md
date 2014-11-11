tutum/container-metrics
=============================

```
    docker run \
      -d \
      -v /var/run:/var/run:rw \
      -v /sys:/sys:ro \
      -v /var/lib/docker/:/var/lib/docker:ro \
      -p 8080:8080 \
      --link influxdb:influxdb \
      -e DB_NAME=cadvisor \
      -e DB_USER=root \
      -e DB_PASS=root \
      tutum/container-metrics
```

**Arguments**

```
    Environment variable: DB_NAME       name of influxdb, "cadvisor" by default
    Environment variable: DB_USER       user of influxdb, "root" by default
    Environment variable: DB_PASS       pass of influxdb, use "INFLUXDB_ENV_INFLUXDB_INIT_PWD" if specified, "root" by default

    INFLUXDB_ENV_INFLUXDB_INIT_PWD      Inherited variable from influxdb, changing default password of influxdb

```

Notice
------
In order to write metrics to local influxdb container, you can start influxdb like this:

```
    docker run -d \
        -p 8084:8084 \
        --name influxdb \
        -e PRE_CREATE_DB="cadvisor;nodemetrics" \
        -e SSL_SUPPORT=true \
        tutum/influxdb:latest
```
