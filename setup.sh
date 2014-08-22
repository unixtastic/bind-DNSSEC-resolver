#!/bin/sh

# Setup OS
apt-get -qq update && apt-get -qq upgrade
apt-get -qq install gcc make wget libssl-dev
cd /tmp
wget -q -O bind-9.9.5-P1.tar.gz http://www.isc.org/downloads/file/bind-9-9-5-w1/?version=tar.gz
tar -xzf bind-9.9.5-P1.tar.gz
cd /tmp/bind-9.9.5-P1
./configure --with-openssl --disable-linux-caps
make
groupadd bind
useradd -g bind -d /tmp -M -r -s /bin/false bind
make install
echo 'options { allow-query { any; }; recursion yes; dnssec-validation auto; dnssec-lookaside auto; };' >/usr/local/etc/named.conf

# Setup service
mkdir /etc/service/bind
echo "#!/bin/sh" >/etc/service/bind/run
echo "exec /usr/local/sbin/named -g -4 -c /usr/local/etc/named.conf -u bind" >>/etc/service/bind/run
chmod +x /etc/service/bind/run

# Clean up
cd /
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

