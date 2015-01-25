
packages = %w{
  php54
  php54-cli
  php54-common
  php54-devel
  php54-gd
  php54-intl
  php54-mbstring
  php54-mcrypt
  php54-mysqlnd
  php54-pdo
  php54-pecl-memcache
  php54-pecl-memcached
  php54-process
  php54-xml
  php54-pear
}

packages.each do |package_name|
  package package_name do
    action :install
    notifies :reload, "service[httpd]", :delayed
  end
end
