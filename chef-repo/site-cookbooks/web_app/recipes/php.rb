#
# Cookbook Name:: web_app
# Recipe:: php
#
#

%w{php55u php55u-common php55u-cli  php55u-devel
php55u-pgsql php55u-pdo php55u-mysql
php55u-gd
gd gd-devel
php55u-pecl-jsonc
php55u-intl php55u-mbstring
php55u-opcache
}.each do |php_module|
  package php_module do
      action :install
    end
end

bash "set timezone" do
  user "root"
  code <<-EOL
    cp /etc/php.ini /etc/php.ini.bak
    sed -i 's#;date.timezone =#date.timezone = Asia/Tokyo#' /etc/php.ini 
  EOL
end


bash "set memory_limit" do
  user "root"
  exists="grep '^memory_limit /etc/php.ini'"
  code <<-EOL
    sed -i 's/; memory_limit =.*/memory_limit = 1024M/' /etc/php.ini
  EOL
  not_if exists
end



#bash "apc install" do
#  user "root"
#  code <<-EOL
#    pecl install apc
#  EOL
#end
