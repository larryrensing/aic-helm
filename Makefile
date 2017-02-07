.PHONY: slackbridge ceph bootstrap mariadb keystone memcached rabbitmq common openstack neutron nova cinder heat maas all clean

B64_DIRS := common/secrets
B64_EXCLUDE := $(wildcard common/secrets/*.b64)

CHARTS := slackbridge ceph mariadb rabbitmq memcached keystone glance horizon neutron nova cinder heat maas openstack
COMMON_TPL := common/templates/_globals.tpl

all: common slackbridge ceph bootstrap mariadb rabbitmq memcached keystone glance horizon neutron nova cinder heat maas openstack

common: build-common

slackbridge: build-slackbridge

#ceph: nolint-build-ceph
ceph: build-ceph

bootstrap: build-bootstrap

mariadb: build-mariadb

keystone: build-keystone

cinder: build-cinder

horizon: build-horizon

rabbitmq: build-rabbitmq

glance: build-glance

neutron: build-neutron

nova: build-nova

heat: build-heat

maas: build-maas

memcached: build-memcached

openstack: build-openstack

clean:
	$(shell rm -rf common/secrets/*.b64)
	$(shell rm -rf */templates/_partials.tpl)
	$(shell rm -rf */templates/_globals.tpl)
	echo "Removed all .b64, _partials.tpl, and _globals.tpl files"

build-%:
	if [ -f $*/Makefile ]; then make -C $*; fi
	if [ -f $*/requirements.yaml ]; then helm dep up $*; fi
	helm lint $*
	helm package $*
