#!/bin/bash
if [ ! -f /conf/aria2.conf ]; then
	cp /conf-copy/aria2.conf /conf/aria2.conf
fi
if [ ! -f /conf/on-complete.sh ]; then
	cp /conf-copy/on-complete.sh /conf/on-complete.sh
fi

GROUP_NAME=aria2
USER_NAME=aria2
USER_ID=${PUID:-9001}
GROUP_ID=${PGID:-9001}

echo "Add group \"${GROUP_NAME}\" with GID: ${GROUP_ID}"
addgroup -g ${GROUP_ID} aria2
export GROUP_NAME=`getent group | grep ${GROUP_ID} | cut -d: -f1`
echo "Group name: ${GROUP_NAME}."

echo "Add user \"${USER_NAME}\" with UID: ${USER_ID}"
adduser -D -H -s /bin/bash -u ${USER_ID} -G ${GROUP_NAME} ${USER_NAME}
export USER_NAME=`getent passwd | grep ${USER_ID}:${GROUP_ID} | cut -d: -f1`
echo "User name: ${USER_NAME}."

chown -R ${USER_NAME}:${GROUP_NAME} /conf
chown -R ${USER_NAME}:${GROUP_NAME} /conf-copy
su -c "mkdir -p /data/incomplete" ${USER_NAME}
su -c "mkdir -p /data/complete" ${USER_NAME}

chmod +x /conf/on-complete.sh
su -c "touch /conf/aria2.session" ${USER_NAME}

echo "Starting aria2..."
su -c "aria2c --conf-path=/conf/aria2.conf" ${USER_NAME}
