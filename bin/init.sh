#!/bin/sh

set -e

set_config() {
    source /xray/bin/env.sh
    CONFIG_PATH="/xray/xray-core/server.json"
    cp /xray/xray-core/server.json.template $CONFIG_PATH
    sed -i "s/{{UUID}}/$UUID/g" $CONFIG_PATH
    sed -i "s/{{PASSWORD}}/$PASSWORD/g" $CONFIG_PATH
    sed -i "s/{{EMAIL}}/$EMAIL/g" $CONFIG_PATH
    sed -i "s/{{WEBSOCKET}}/\\$WEBSOCKET/g" $CONFIG_PATH
    sed -i "s/{{VMESSTCP}}/\\$VMESSTCP/g" $CONFIG_PATH
    sed -i "s/{{VMESSWS}}/\\$VMESSWS/g" $CONFIG_PATH
}

self_signature() {
    ORGANIZATION="$(md5sum /proc/sys/kernel/random/uuid | cut -d ' ' -f1)"
    openssl req -newkey rsa:2048 -nodes -keyout $TARGET/key_$ORGANIZATION.pem -x509 -days 3650 -subj "/C=HK/ST=Tuen Mun District/L=Tuen Mun District/O=$ORGANIZATION/OU=$ORGANIZATION Software/CN=$ORGANIZATION.com/emailAddress=software@$ORGANIZATION.com" -out $TARGET/cert_$ORGANIZATION.pem
    ln -s $TARGET/key_$ORGANIZATION.pem $TARGET/key
    ln -s $TARGET/cert_$ORGANIZATION.pem $TARGET/cert
}

certbot_signature() {
    certbot certonly --nginx -n -d $HOST --agree-tos --keep --email "$(md5sum /proc/sys/kernel/random/uuid | cut -d ' ' -f1)@gmail.com"
    ln -s /etc/letsencrypt/live/$HOST/fullchain.pem $TARGET/cert
    ln -s /etc/letsencrypt/live/$HOST/privkey.pem $TARGET/key

    # set auto renew
    if [ ! -f /etc/periodic/daily/auto_cert ]
    then
        echo -e "#!/bin/sh\nsh /xray/bin/init.sh renew_cert" >> /etc/periodic/daily/auto_cert
        chmod +x /etc/periodic/daily/auto_cert
    else
        echo "auto_cert cron has exist"
    fi
}

renew_cert() {
    if [ ! -f $TARGET/cert -o ! -f $TARGET/key ]
    then
        echo "not found cert"
        exit 1
    fi

    OLD_KEY="$(md5sum $TARGET/key)"
    certbot renew
    NEW_KEY="$(md5sum $TARGET/key)"

    if [ "$OLD_KEY" == "$NEW_KEY" ]
    then
        echo "not need renew"
        exit
    fi

    supervisorctl restart xray
}

set_cert() {
    TARGET="/xray/certificate"
    if [ -f $TARGET/cert -a -f $TARGET/key ]
    then
        return
    fi

    rm -rf $TARGET
    mkdir -p $TARGET
    
    if [ "$HOST" == "" ]
    then
        self_signature
    else
        certbot_signature
    fi
}

case $1 in
    'config')
        set_config
        ;;
    'cert')
        set_cert
        ;;
    'renew_cert')
        TARGET="/xray/certificate"
        renew_cert
        ;;
    'cert_self')
        TARGET="/xray/certificate"
        rm -rf $TARGET
        mkdir -p $TARGET
        self_signature
        ;;
    'certbot_signature')
        TARGET="/xray/certificate"
        rm -rf $TARGET
        mkdir -p $TARGET
        certbot_signature
        ;;
    *)
        set_config
        set_cert
        ;;
esac