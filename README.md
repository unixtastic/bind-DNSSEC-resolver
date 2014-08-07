Docker-bind-DNSSEC-resolver
===========================

A minimal BIND based DNSSEC resolver for docker.

Build instructions:
===================

git clone https://github.com/unixtastic/bind-DNSSEC-resolver

docker build -t 'unixtastic/bind-DNSSEC-resolver' .

Usage instructions:
===================

docker run -d -p 53:53/udp -p 53:53 unixtastic/bind-DNSSEC-resolver

It is recommended to forward port 53 on both UDP and TCP as large replies
may failover to TDP.

Notes:
======

This is a BIND based minimal DNSSEC resolver. It uses the internet root zone
keys and the ISC's lookaside keys to cryptographical validate DNS data. It will
also resolve non-DNSSEC enabled domains.

This Dockerfile rebuilds BIND from the official ISC sources. The BIND
configuration is kept absolutely minimal.

Note that using the same DNS daemon as both a DNS server and a DNS resolver is not
considered best practice and may make cache poisioning or DOS attacks more likely.
This image is deliberately just a DNS resolver. As the resolver libraries have
no way to query on any port except 53 running a server and resolver on the
same IP isn't possible. You may run both on the same machine only if you use two
IPs.

TODO: Consider adding reply rate limiting (RRL) to this.

