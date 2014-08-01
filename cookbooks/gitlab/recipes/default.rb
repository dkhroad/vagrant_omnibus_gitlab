omnibus_package = node[:gitlab][:package]
omnibus_package_url = "#{node[:gitlab][:url]}/#{omnibus_package}" 

remote_file "#{Chef::Config[:file_cache_path]}/#{omnibus_package}" do 
  source omnibus_package_url
  checksum "72b794d86941bdbc684c0dbd96a957dd"
  action :create_if_missing
end

rpm_package "omnibus_gitlab" do 
  source "#{Chef::Config[:file_cache_path]}/#{omnibus_package}"
end

directory node[:gitlab][:git_data_dir] do 
  action :create
  owner  "git"
end

directory node[:gitlab][:backup_path] do 
  action :create
  owner  "git"
end


template "/etc/gitlab/gitlab.rb" do 
  owner "root"
  group "root"
  source "gitlab.rb.erb"
  notifies :run, "execute[reconfigure]", :immediately
end

execute "reconfigure" do 
  command "/opt/gitlab/bin/gitlab-ctl reconfigure"
end

