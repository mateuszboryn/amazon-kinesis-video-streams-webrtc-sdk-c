#!/bin/bash

set -e


cd "$(dirname "$0")"

source creds.sh

cd ../build/

export AWS_KVS_VERBOSE=1
export GST_DEBUG=3

# ./kvsWebrtcClientMasterGstSample test audio-video
./kvsWebrtcClientMasterGstSample test video-only
