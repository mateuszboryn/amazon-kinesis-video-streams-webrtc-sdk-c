#!/bin/bash

set -e


cd "$(dirname "$0")"

source creds.sh

cd ../sample-lib-dependent/build/
# cd ../build-1.5.0-iot/
# cd ../build/

export AWS_KVS_VERBOSE=1
# export AWS_KVS_LOG_LEVEL=1
export GST_DEBUG=3

export AWS_KVS_CACERT_PATH=../../certs/cert.pem

# LD_LIBRARY_PATH=../open-source/lib ./kvsWebrtcClientMasterGstSample test audio-video

# LD_LIBRARY_PATH=../open-source/lib ./kvsWebrtcClientMasterGstSample ${SIGNALLING_CHANNEL_NAME} video-only
LD_LIBRARY_PATH=/home/pi/kvs-os-libs/lib/ ./kvsWebrtcClientMasterGstSample ${SIGNALLING_CHANNEL_NAME} video-only

# LD_LIBRARY_PATH=../open-source/lib ./kvsWebrtcClientMasterGstSample eu-west-1:27302e61-a0b3-43b6-8d99-64bf347fe18b video-only
