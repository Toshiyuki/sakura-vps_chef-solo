#
# php
#

remote_file "/tmp/epel-release-6-8.noarch.rpm" do
    source "http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/6/x86_64/epel-release-6-8.noarch.rpm"
end
package "epel-release" do
    action :install
    not_if "rpm -q epel-release"
    source "/tmp/epel-release-6-8.noarch.rpm"
end

remote_file "/tmp/remi-release-6.rpm" do
    source "http://rpms.famillecollet.com/enterprise/remi-release-6.rpm"
end

package "remi-release" do
    action :install
    not_if "rpm -q remi-release"
    source "/tmp/remi-release-6.rpm"
end

remote_file "/tmp/nginx-release-centos-6-0.el6.ngx.noarch.rpm" do
    source "http://nginx.org/packages/centos/6/noarch/RPMS/nginx-release-centos-6-0.el6.ngx.noarch.rpm"
end
package "nginx" do
    action :install
    not_if "rpm -q nginx"
    source "/tmp/nginx-release-centos-6-0.el6.ngx.noarch.rpm"
end

#
# Package install
#
%w{
    wget
    crontabs
    pcre-devel
    php
    httpd
    mod_ssl
    php-pgsql
    php-mysql
    php-mbstring
    php-gd
    php-imap
    php-dom
    php-devel
    php-pecl-apc
    php-pdo
    php-xml
    php-pear
    php-soap
    php-gd
    php-mcrypt
    postfix
    automake
    libtool
    gcc-c++
    openssl-devel
    zlib-devel
    make
    readline-devel
    bzip2-devel
    ImageMagick
    memcached
    xpdf
    s3cmd
    sysstat
}.each do |pkgname|
    package "#{pkgname}" do
        action :install
        not_if "rpm -q #{pkgname}"
    end
end

remote_file "/tmp/pgdg-centos92-9.2-6.noarch.rpm" do
    source "http://yum.postgresql.org/9.2/redhat/rhel-6-x86_64/pgdg-centos92-9.2-6.noarch.rpm"
end

package "yum.postgresql.org" do
    action :install
    not_if "rpm -q yum.postgresql.org"
    source "/tmp/pgdg-centos92-9.2-6.noarch.rpm"
end


git "/tmp/phantomjs" do
    repository "git://github.com/ariya/phantomjs.git"
    action :sync
end

execute "install-phantomjs" do
    command "cd /tmp/phantomjs && ./build.sh --confirm"
end


#
# service
#
service "httpd" do
    action [ :enable , :restart ]
end

service "postgresql" do
    action [ :enable , :restart ]
end



