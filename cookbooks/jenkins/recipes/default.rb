#
# jenkins
#

#
# Package install
#
remote_file "/etc/yum.repos.d/jenkins.repo" do
    source "http://pkg.jenkins-ci.org/redhat/jenkins.repo"
end

execute "jenkins install" do
    command "rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key && yum -y install jenkins"
end

#
# service
#
service "jenkins" do
    action [ :enable , :start ]
end




