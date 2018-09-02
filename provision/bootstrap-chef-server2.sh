#!/usr/bin/env bash
wget -P /tmp https://packages.chef.io/files/stable/chef-server/12.17.33/el/7/chef-server-core-12.17.33-1.el7.x86_64.rpm
yum install -y /tmp/chef-server-core-12.17.33-1.el7.x86_64.rpm

chown -R vagrant:vagrant /home/vagrant

mkdir /home/vagrant/certs

chef-server-ctl reconfigure
printf "\033c"
chef-server-ctl user-create testlabdev Test Lab testlab@testlab.com password --filename /home/vagrant/certs/testchef_usr.pem
chef-server-ctl org-create testcheflab "Test Chef Lab" --association_user testlabdev --filename /home/vagrant/certs/testchef_org.pem
chef-server-ctl install chef-manage
chef-server-ctl reconfigure
chef-manage-ctl reconfigure --accept-license

chef-server-ctl install opscode-reporting
chef-server-ctl reconfigure
opscode-reporting-ctl reconfigure --accept-license


# configure hosts file for our internal network defined by Vagrantfile
cat >> /etc/hosts <<EOL
# vagrant environment nodes
10.0.15.10  chef-server
10.0.15.15  lb
10.0.15.22  web1
10.0.15.23  web2
EOL

printf "\033c"
echo "Chef Console is ready: http://chef-server with login: testlabdev password: password"
