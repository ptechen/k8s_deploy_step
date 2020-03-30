#!/bin/bash

yum -y install ntp ntpdate

ntpdate cn.pool.ntp.org

hwclock --systohc

hwclock -w