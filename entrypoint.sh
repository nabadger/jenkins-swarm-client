#!/bin/sh
set -e

FSROOT="${FSROOT:-/tmp/jenkins}"
java -jar swarm-client.jar -fsroot=${FSROOT} "$@"
