# Sample lib-dependent

This sample is built using separate CMake invocation. It requires 
the webrtc to be already built.

## Build webrtc library

```
mkdir build && cd build
OPEN_SRC_INSTALL_PREFIX=/home/pi/kvs-os-libs
INSTALL_PREFIX=/home/pi/kvs-webrtc
cmake .. -DCMAKE_INSTALL_PREFIX=${INSTALL_PREFIX} -DOPEN_SRC_INSTALL_PREFIX=${OPEN_SRC_INSTALL_PREFIX}
make install
```

