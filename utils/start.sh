#!/bin/bash

set -e

cd "$(dirname "$0")"

source creds.sh

cd ../build/

./kvsWebrtcClientMaster test
