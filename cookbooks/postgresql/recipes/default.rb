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
remote_file "/tmp/postgresql-9.2.4.tar.gz" do
    source "http://ftp.postgresql.org/pub/source/v9.2.4/postgresql-9.2.4.tar.gz"
end
execute "install-postgresql" do
    command "cd /tmp/ && tar zxvf postgresql-9.2.4.tar.gz && cd postgresql-9.2.4 && ./configure && make && make install"
end
execute "setting1-postgresql" do
    command "cd /tmp/postgresql-9.2.4/ && contrib/start-scripts/linux /etc/init.d/postgresql && chmod 755 /etc/init.d/postgresql"
end
execute "setting2-postgresql" do
    command "mkdir /usr/local/pgsql/data/ && chown postgres:postgres /usr/local/pgsql/data/ && su - postgres && /usr/local/pgsql/bin/initdb -D /usr/local/pgsql/data/ --no-locale -E UTF8 && exit"
end

#
# service
#
service "postgresql" do
    action [ :enable , :restart ]
end


