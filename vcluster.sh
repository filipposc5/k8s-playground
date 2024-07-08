#!/bin/bash
set -e

wget https://github.com/loft-sh/vcluster/releases/download/v0.19.5/vcluster-linux-amd64
install -m 755 vcluster-linux-amd64 /usr/local/bin/vcluster
rm vcluster-linux-amd64

vcluster create vcluster-1
