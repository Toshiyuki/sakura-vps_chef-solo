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
    action :create
end
directory "/home/postgres" do
    owner "postgres"
    group "postgres"
    mode 00755
    action :create
end

remote_file "/tmp/postgresql-9.2.4.tar.gz" do
    source "http://ftp.postgresql.org/pub/source/v9.2.4/postgresql-9.2.4.tar.gz"
end
execute "install-postgresql" do
    command "cd /tmp/ && tar zxvf postgresql-9.2.4.tar.gz && cd postgresql-9.2.4 && ./configure && make && make install"
end


execute "cp /tmp/contrib/start-scripts/linux /etc/init.d/postgresql && chmod 755 /etc/init.d/postgresql" do
    not_if { ::FileTest.exist?("/etc/init.d/postgresql") }
end


execute "mkdir -p /usr/local/pgsql/data/ && chown postgres:postgres /usr/local/pgsql/data/ && /sbin/service postgresql initdb" do
    not_if { ::FileTest.exist?("/usr/local/pgsql/data/PG_VERSION") }
end


#
# service
#
service "postgresql" do
    action [ :enable , :start ]
end


