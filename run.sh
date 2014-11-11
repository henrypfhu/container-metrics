#! /bin/bash
echo "==============================="
/cadvisor -h
echo "==============================="

if [ -n "${INFLUXDB_PORT_8086_TCP_ADDR}" ] && [ -n "${INFLUXDB_PORT_8086_TCP_PORT}" ]; then
    echo "=> Found influxdb link, cAdvisor is writting to influxdb"
    DBHOST=${INFLUXDB_PORT_8086_TCP_ADDR}
    DBPORT=${INFLUXDB_PORT_8086_TCP_PORT}
    DBNAME=${DB_NAME}
    DBUSER=${DB_USER}
    DBPASS=${INFLUXDB_ENV_INFLUXDB_INIT_PWD:-${DB_PASS}}
    echo "====INFLUX DB SPEC====="
    echo "  host:${DBHOST}:${DBPORT}"
    echo "  name:${DBNAME}"
    echo "  user:${DBUSER}"
    echo "  pass:${DBPASS}"
    echo "====INFLUX DB SPEC===="
    exec /cadvisor -logtostderr -storage_driver="influxdb" -storage_driver_host="${DBHOST}:${DBPORT}" -storage_driver_db="${DBNAME}" -storage_driver_user="${DBUSER}" -storage_driver_password="${DBPASS}"
else
    echo "=> cAdvisor is writing to memory"
    exec /cadvisor -logtostderr
fi
