#!/bin/bash

set -e

REPLSETNAME=${REPLSETNAME:=default}
REPLSETMEMBERS=${REPLSETMEMBERS:=1}
AUTH=${AUTH:=false}
USERNAME=${USERNAME:=root}
PASSWORD=${PASSWORD:=root}

SUPERVISOR_CONF_D=/etc/supervisor/conf.d
INIT_SCRIPT=/tmp/init.js
KEYFILE_PATH=/tmp/mongodb-keyfile
IPADDR=$(dirname $(ip -f inet -o addr show eth0|awk '{print $4}'))


ensure_run_begin() {
    file=$1
    wait_time=$2
    wait_time=${wait_time:-5000}
    echo "var err;" >> ${file}
    echo "do {" >> ${file}
    echo "    sleep(${wait_time});" >> ${file}
    echo "    err = null;" >> ${file}
    echo "    try {" >> ${file}
}

ensure_run_end() {
    file=$1
    echo "    } catch(error) {" >> ${file}
    echo "        err = error;" >> ${file}
    echo "    }" >> ${file}
    echo "} while(err !== null);" >> ${file}
}


# use keyFile option if AUTH is enabled
if [ "${AUTH}" != "false" ]; then
    openssl rand -base64 741 > ${KEYFILE_PATH}
    chmod 600 ${KEYFILE_PATH}
    chown mongodb:mongodb ${KEYFILE_PATH}
    KEYFILE="--keyFile ${KEYFILE_PATH}"
else
    KEYFILE=
fi


# generate the initialization script for mongodb
ensure_run_begin ${INIT_SCRIPT}
echo "rs.initiate({_id: \"${REPLSETNAME}\", members: [" >> ${INIT_SCRIPT}

for i in $(seq "${REPLSETMEMBERS}"); do
    PORT=$(expr 27016 + $i)
    DBPATH="/var/lib/mongodb/${REPLSETNAME}-${i}"

    mkdir -p ${DBPATH}
    chown mongodb ${DBPATH}

    # generate supervisor configuration files for running mongod
    cat > "${SUPERVISOR_CONF_D}/mongodb-${i}.conf" <<EOF
[program:mongodb-${i}]
user = mongodb
command = /usr/bin/mongod --config /etc/mongodb.conf --replSet '${REPLSETNAME}' --port '${PORT}' --dbpath '${DBPATH}' ${KEYFILE}
autorestart = true
EOF

    echo "{_id: ${i}, host: \"${IPADDR}:${PORT}\"}," >> ${INIT_SCRIPT}
done

echo "]});" >> ${INIT_SCRIPT}
ensure_run_end ${INIT_SCRIPT}


# add an administrator account if AUTH is enabled
if [ "${AUTH}" != "false" ]; then
    echo "" >> ${INIT_SCRIPT}
    echo "use admin" >> ${INIT_SCRIPT}
    echo "" >> ${INIT_SCRIPT}
    ensure_run_begin ${INIT_SCRIPT}
    echo "db.addUser(\"${USERNAME}\", \"${PASSWORD}\");" >> ${INIT_SCRIPT}
    ensure_run_end ${INIT_SCRIPT}
    echo "" >> ${INIT_SCRIPT}
    echo "exit" >> ${INIT_SCRIPT}
fi


# start supervisord
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
