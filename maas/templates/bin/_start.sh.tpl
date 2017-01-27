#!/bin/bash
set -ex

echo 'running postinst'

chmod 755 /var/lib/dpkg/info/maas-region-controller.postinst
/bin/sh /var/lib/dpkg/info/maas-region-controller.postinst configure

maas-region createadmin --username={{ .Values.credentials.admin_username }} --password={{ .Values.credentials.admin_password }} --email={{ .Values.credentials.admin_email }} || true
