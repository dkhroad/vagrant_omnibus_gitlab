default[:gitlab][:package] = "gitlab-7.1.1_omnibus-1.el6.x86_64.rpm" 
default[:gitlab][:url] = "https://downloads-packages.s3.amazonaws.com/centos-6.5"

default[:gitlab][:external_url]="http://www.example.com"
default[:gitlab][:git_data_dir]="/opt/mount//git-data"


default[:gitlab][:backup_path] = "/opt/mount/backups" 
default[:gitlab][:backup_keep_time] = 604800 

