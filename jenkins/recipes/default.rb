execute "install-jenkins-repo" do
  command <<-_EOH_
    wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
    rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
  _EOH_
  action :run
  not_if { ::File.exists?("/etc/yum.repos.d/jenkins.repo") }
end
 
package "jenkins" do
  action :install
end

template "/etc/sysconfig/jenkins" do
        source "jenkins.erb"
        owner "root"
        group "root"
        mode 0600
end
 
service "jenkins" do
  action [:enable, :start]
end
 
%w{aws-cli jq}.each do |name|
  package name do
    action :install
  end
end
