# Use gnocchi+auth in the pipeline if you want to use keystone authentication
[pipeline:main]
pipeline = gnocchi+noauth

[composite:gnocchi+noauth]
use = egg:Paste#urlmap
/ = gnocchiversions
/v1 = gnocchiv1+noauth

[composite:gnocchi+auth]
use = egg:Paste#urlmap
/ = gnocchiversions
/v1 = gnocchiv1+auth

[pipeline:gnocchiv1+noauth]
pipeline = gnocchiv1

[pipeline:gnocchiv1+auth]
pipeline = keystone_authtoken gnocchiv1

[app:gnocchiversions]
paste.app_factory = gnocchi.rest.app:app_factory
root = gnocchi.rest.VersionsController

[app:gnocchiv1]
paste.app_factory = gnocchi.rest.app:app_factory
root = gnocchi.rest.V1Controller

[filter:keystone_authtoken]
paste.filter_factory = keystonemiddleware.auth_token:filter_factory
oslo_config_project = gnocchi
