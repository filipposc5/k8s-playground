#!/bin/bash

# set -e
curl -s https://fluxcd.io/install.sh | sudo bash
flux install
