package "nginx" do
	action :install
end

directory node[:nginx][:dir] do
  owner 'root'
  group 'root'
  mode 0755
end

directory node[:nginx][:log_dir] do
  mode 0755
  owner node[:nginx][:user]
  action :create
end

service "nginx" do
	supports status: true, restart: true, reload:true
	action [:enable, :start]
end
template "#{node[:nginx][:dir]}/nginx.conf" do
	source "nginx.conf.erb"
	owner "root"
	group "root"
	mode 0644
end

template "#{node[:nginx][:dir]}/conf.d/jenkins.conf" do
	source "jenkins-site.erb"
	owner "root"
	group "root"
	mode 0644
end
