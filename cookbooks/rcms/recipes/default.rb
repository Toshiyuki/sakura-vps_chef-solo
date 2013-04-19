#
# php
#

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
    vixie-cron
}.each do |pkgname|
    package "#{pkgname}" do
        action :install
        not_if "rpm -q #{pkgname}"
    end
end


#
# service
#
service "httpd" do
    action [ :enable , :restart ]
end




