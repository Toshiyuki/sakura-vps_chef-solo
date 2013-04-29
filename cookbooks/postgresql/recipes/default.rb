#
# postgresql
#

#
# Package install
#
%w{
    automake
    libtool
    gcc
    gcc-c++
    openssl-devel
    zlib-devel
    make
    readline-devel
    bzip2-devel
}.each do |pkgname|
    package "#{pkgname}" do
        action :install
        not_if "rpm -q #{pkgname}"
    end
end


user "postgres" do
    home "/home/postgres"
    supports :manage_home=>true
    action :create
end

remote_file "/tmp/postgresql-9.2.4.tar.gz" do
    source "http://ftp.postgresql.org/pub/source/v9.2.4/postgresql-9.2.4.tar.gz"
end
execute "install-postgresql" do
    command "cd /tmp/ && tar zxvf postgresql-9.2.4.tar.gz && cd postgresql-9.2.4 && ./configure && make && make install"
end

cookbook_file "/tmp/setting-postgresql" do
    source "setting-postgresql"
end

execute "setting-postgresql" do
    command "sh /tmp/setting-postgresql"
end


#
# service
#
service "postgresql" do
    action [ :enable , :restart ]
end


