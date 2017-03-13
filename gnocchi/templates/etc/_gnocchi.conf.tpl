[DEFAULT]
debug = {{ .Values.api.default.debug }}
use_syslog = false
use_stderr = true

[api]
paste_config = /etc/gnocchi/api-paste.ini
auth_mode = keystone


[database]
#connection = mysql+pymysql://{{ .Values.database.gnocchi_user }}:{{ .Values.database.gnocchi_password }}@{{ include "helm-toolkit.mariadb_host" . }}/{{ .Values.database.gnocchi_database_name }}
#max_retries = -1


[indexer]
# Indexer driver to use (string value)
url = {{ tuple "oslo_db" "internal" "user" "postgresql" . | include "helm-toolkit.authenticated_endpoint_uri_lookup" }}?client_encoding=utf8


[keystone_authtoken]
auth_uri = {{ tuple "identity" "internal" "api" . | include "helm-toolkit.keystone_endpoint_uri_lookup" }}
auth_version = v3
region_name = {{ .Values.keystone.gnocchi_region_name }}
project_domain_name = {{ .Values.keystone.gnocchi_project_domain }}
project_name = {{ .Values.keystone.gnocchi_project_name }}
user_domain_name = {{ .Values.keystone.gnocchi_user_domain }}
username = {{ .Values.keystone.gnocchi_user }}
password = {{ .Values.keystone.gnocchi_password }}

memcached_servers = memcached:11211

[statsd]

#
# From gnocchi
#

# The listen IP for statsd (string value)
#host = 0.0.0.0

# The port for statsd (port value)
# Minimum value: 0
# Maximum value: 65535
#port = 8125

# Resource UUID to use to identify statsd in Gnocchi (unknown value)
#resource_id = <None>

# User ID to use to identify statsd in Gnocchi (string value)
#user_id = <None>

# Project ID to use to identify statsd in Gnocchi (string value)
#project_id = <None>

# Archive policy name to use when creating metrics (string value)
#archive_policy_name = <None>

# Delay between flushes (floating point value)
#flush_delay = 10


[storage]

#
# From gnocchi
#

# Number of workers to run during adding new measures for pre-aggregation
# needs. Due to the Python GIL, 1 is usually faster, unless you have high
# latency I/O (integer value)
# Minimum value: 1
#aggregation_workers_number = 1

# Coordination driver URL (string value)
#coordination_url = <None>

# Storage driver to use (string value)
#driver = file

# How many seconds to wait between scheduling new metrics to process (integer
# value)
#metric_processing_delay = 60

# How many seconds to wait between metric ingestion reporting (integer value)
#metric_reporting_delay = 120

# How many seconds to wait between cleaning of expired data (integer value)
#metric_cleanup_delay = 300

# Ceph pool name to use. (string value)
#ceph_pool = gnocchi

# Ceph username (ie: admin without "client." prefix). (string value)
#ceph_username = <None>

# Ceph key (string value)
#ceph_secret = <None>

# Ceph keyring path. (string value)
#ceph_keyring = <None>

# Ceph configuration file. (string value)
#ceph_conffile = /etc/ceph/ceph.conf

# Path used to store gnocchi data files. (string value)
#file_basepath = /var/lib/gnocchi

# Path used to store Gnocchi temporary files. (string value)
#file_basepath_tmp = ${file_basepath}/tmp

# Swift authentication version to user. (string value)
#swift_auth_version = 1

# Swift pre-auth URL. (string value)
#swift_preauthurl = <None>

# Swift auth URL. (string value)
#swift_authurl = http://localhost:8080/auth/v1.0

# Swift token to user to authenticate. (string value)
#swift_preauthtoken = <None>

# Swift user. (string value)
#swift_user = admin:admin

# Swift user domain name. (string value)
#swift_user_domain_name = Default

# Swift key/password. (string value)
#swift_key = admin

# Swift tenant name, only used in v2/v3 auth. (string value)
# Deprecated group/name - [storage]/swift_tenant_name
#swift_project_name = <None>

# Swift project domain name. (string value)
#swift_project_domain_name = Default

# Prefix to namespace metric containers. (string value)
#swift_container_prefix = gnocchi

# Endpoint type to connect to Swift (string value)
#swift_endpoint_type = publicURL

# Connection timeout in seconds. (integer value)
# Minimum value: 0
#swift_timeout = 300