#!/bin/bash

set -e


cd "$(dirname "$0")"

source creds.sh

cd ../build/

export AWS_KVS_VERBOSE=1
# export AWS_KVS_LOG_LEVEL=1
export GST_DEBUG=3

# LD_LIBRARY_PATH=../open-source/lib ./kvsWebrtcClientMasterGstSample test audio-video
LD_LIBRARY_PATH=../open-source/lib ./kvsWebrtcClientMasterGstSample ${SIGNALLING_CHANNEL_NAME} video-only
# LD_LIBRARY_PATH=../open-source/lib ./kvsWebrtcClientMasterGstSample eu-west-1:27302e61-a0b3-43b6-8d99-64bf347fe18b video-only
