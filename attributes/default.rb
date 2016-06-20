default['aide']['package']['install'] = "aide"
default['aide']['config']['directory'] = "/etc/aide"
default['aide']['wrapper']['directory'] = "/etc/default"
default['aide']['config']['src'] = "aide.conf.erb"
default['aide']['wrapper']['src'] = "aide.erb"

default['aide']['db']['new'] = "/var/lib/aide/aide.db.new"
default['aide']['db']['using'] = "/var/lib/aide/aide.db"

default['aide']['cron']['directory'] = "/usr/local/etc"
default['aide']['cron']['src'] = "cron_aide.sh"
default['aide']['cron']['chmod'] = "0755"

default['aide']['email'] = ""
