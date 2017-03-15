#!/bin/bash

# Copyright 2017 The Openstack-Helm Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -ex
export HOME=/tmp


function wait_for_api {
	# note: sleep to wait until nova api is actually serving on
	# the appropriate port.  not pretty, there has to be a cleaner approach to this
	sleep 30
	nova flavor-list 2>/dev/null
}

cat <<EOF>/tmp/openrc
export OS_USERNAME={{.Values.keystone.admin_user}}
export OS_PASSWORD={{.Values.keystone.admin_password}}
export OS_PROJECT_DOMAIN_NAME={{.Values.keystone.admin_user_domain}}
export OS_USER_DOMAIN_NAME={{.Values.keystone.admin_user_domain}}
export OS_PROJECT_NAME={{.Values.keystone.admin_project_name}}
export OS_AUTH_URL={{ tuple "identity" "internal" "api" . | include "helm-toolkit.keystone_endpoint_uri_lookup" }}
export OS_AUTH_STRATEGY=keystone
export OS_REGION_NAME={{.Values.keystone.admin_region_name}}
export OS_INSECURE=1
EOF

. /tmp/openrc

wait_for_api

{{ range .Values.bootstrap.flavors }}
nova flavor-show {{ .name }} || \
 nova flavor-create {{ .name }} {{ .id }} {{ .ram }} {{ .disk }} {{ .vcpus }}
{{ end }}