# yum_repository 'nginx_repo' do
#   description "Nginx Stable repo"
#   baseurl "http://nginx.org/packages/centos/$releasever/$basearch/"
#   gpgcheck false
#   enabled true
#   action :create
# end

template "/etc/yum.repos.d/nginx.repo" do 
  source "nginx.repo.erb"
  owner "root"
  group "root"
end

yum_package "nginx"

template "/etc/nginx/conf.d/default.conf" do 
  source "default.conf.erb"
  owner "root"
  group "root" 
  notifies :reload, "service[nginx]", :delayed
end

template "/etc/nginx/nginx.conf" do 
  source "nginx.conf.erb"
  owner "root"
  group "root" 
  notifies :reload, "service[nginx]", :delayed
end

service "nginx" do
  action :nothing
end
