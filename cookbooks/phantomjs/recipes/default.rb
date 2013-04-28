#
# phantomjs
#

#
# Package install
#
%w{
    gcc
    gcc-c++
    openssl-devel
    zlib-devel
    make
    freetype-devel
    fontconfig-devel
}.each do |pkgname|
    package "#{pkgname}" do
        action :install
        not_if "rpm -q #{pkgname}"
    end
end


git "/tmp/phantomjs" do
    repository "git://github.com/ariya/phantomjs.git"
    revision "1.9"
    action :sync
end

execute "install-phantomjs" do
    command "cd /tmp/phantomjs && ./build.sh --confirm"
end


