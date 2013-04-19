#
# php
#

package "epel" do
    action :install
    not_if "rpm -q epel-release"
    source "http://ftp-srv2.kddilabs.jp/Linux/distributions/fedora/epel/6/x86_64/epel-release-6-7.noarch.rpm"
end
package "remi" do
    action :install
    not_if "rpm -q remi-release"
    source "http://rpms.famillecollet.com/enterprise/remi-release-6.rpmm"
end
package "nginx" do
    action :install
    not_if "rpm -q nginx"
    source "http://nginx.org/packages/centos/5/noarch/RPMS/nginx-release-centos-5-0.el5.ngx.noarch.rpm"
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

remote_file "/tmp/postgresql-9.2.4.tar.gz" do
    source "http://ftp.postgresql.org/pub/source/v9.2.4/postgresql-9.2.4.tar.gz"
end

execute "install-postgresql" do
    command "tar zxvf /tmp/postgresql-9.2.4.tar.gz -C /tmp/ && cd /tmp/postgresql-9.2.4 && ./configure && make && make install"
end

execute "setup-postgresql" do
    command "cp /tmp/postgresql-9.2.4/contrib/start-scripts/linux /etc/init.d/postgresql && chmod 755 /etc/init.d/postgresql"
end



#
# service
#
service "httpd" do
    action [ :enable , :restart ]
end




