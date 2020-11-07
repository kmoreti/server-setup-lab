cd /tmp || exit 1
curl -fsSL https://releases.hashicorp.com/vagrant/2.2.13/vagrant_2.2.13_x86_64.deb -o vagrant_2.2.13_x86_64.deb
apt install /tmp/vagrant_2.2.13_x86_64.deb
vagrant --version
