#! /usr/bin/env/bash

cat > /root/appliance/management.appliance.reconf.sh <<EOF
export ETC_PATH=$ETC_PATH
export REPO_PATH=$REPO_PATH

export HTTP_PROXY=$HTTP_PROXY
export NO_PROXY=$NO_PROXY
export http_proxy=$http_proxy
export no_proxy=$no_proxy

export PLAYBOOK="$PLAYBOOK -v"

export CONSUL_DATACENTER=$CONSUL_DATACENTER
export CONSUL_DNS_DOMAIN=$CONSUL_DNS_DOMAIN
export CONSUL_BOOTSTRAP_EXPECT=$CONSUL_BOOTSTRAP_EXPECT
export CONSUL_ENCRYPT=$CONSUL_ENCRYPT

export VAULT_CONTAINER=$VAULT_CONTAINER

export BACK_IP=$BACK_IP
export NTP_SERVER=$NTP_SERVER

export TRAEFIK_CONSUL_PREFIX=$TRAEFIK_CONSUL_PREFIX

export OS_AUTH_URL=$OS_AUTH_URL
export OS_IDENTITY_API_VERSION=$OS_IDENTITY_API_VERSION
export OS_INTERFACE=$OS_INTERFACE
export OS_PASSWORD=$OS_PASSWORD
export OS_PROJECT_DOMAIN_ID=$OS_PROJECT_DOMAIN_ID
export OS_PROJECT_ID=$OS_PROJECT_ID
export OS_PROJECT_NAME=$OS_PROJECT_NAME
export OS_REGION_NAME=$OS_REGION_NAME
export OS_USERNAME=$OS_USERNAME
export OS_USER_DOMAIN_NAME=$OS_USER_DOMAIN_NAME

sed -i 's/exit 1/false/' $REPO_PATH/management.appliance.autoconf.sh

. $REPO_PATH/management.appliance.autoconf.sh
EOF

export TMP_BIN=/tmp/bin

# Get binaries
if swift list | grep -q binaries ; then
	swift download --output-dir=$TMP_BIN binaries
	for z in $TMP_BIN/*.zip ; do
		unzip -d /usr/local/bin $z && rm -f $z
	done

	if [ -d $TMP_BIN ] ; then
		cd /usr/local/bin
		for t in $TMP_BIN/*.gz ; do
			tar xf $t && rm -f $t
		done
		mv $TMP_BIN/* /usr/local/bin/
	fi
fi

chmod +x /usr/local/bin/*

rm -rf $TMP_BIN

if curl -qs https://forge.dgfip.finances.rie.gouv.fr 2>&1 > /dev/null ; then
	export remote_repo="intranet"
else
	export remote_repo="internet"
fi

ansible-galaxy install -r $ETC_PATH/appliance.ansible_requirements.${remote_repo}.yml

sed -i 's/hosts: all/hosts: localhost/' $PLAYBOOK

ansible-playbook -i localhost $PLAYBOOK \
	-e@$ETC_PATH/appliance.variables.yml \
	|| exit 1

