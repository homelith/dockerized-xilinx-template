#!/bin/bash -xe
/etc/init.d/xrdp start && tail -F /var/log/xrdp-sesman.log
