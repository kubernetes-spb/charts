#!/bin/sh

### additional tweaks for docker env
sysctl -w vm.max_map_count=262144 || { echo "Can not set vm.max_map_count sysctl value, exiting..."; exit 1; }
ulimit -l unlimited

### change permissons to data folder so ES can use it
chown -R elasticsearch data

### launch ES
gosu elasticsearch bin/elasticsearch "$@"
