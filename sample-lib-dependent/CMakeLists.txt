cmake_minimum_required(VERSION 3.6.3)

set(OPEN_SRC_INSTALL_PREFIX "${CMAKE_CURRENT_SOURCE_DIR}/open-source" CACHE PATH "Libraries will be downloaded and build in this directory.")

find_package(PkgConfig REQUIRED)

set(OPEN_SRC_LIB_DIR ${OPEN_SRC_INSTALL_PREFIX}/lib)

#find_library (ssl_LIB ssl PATHS ${OPEN_SRC_LIB_DIR} NO_DEFAULT_PATH)
#find_library (crypto_LIB crypto PATHS ${OPEN_SRC_LIB_DIR} NO_DEFAULT_PATH)
#find_library (websockets_LIB websockets PATHS ${OPEN_SRC_LIB_DIR} NO_DEFAULT_PATH)
#find_library (kvspicUtils_LIB kvspicUtils PATHS ${OPEN_SRC_LIB_DIR} NO_DEFAULT_PATH)
#find_library (kvsCommonLws_LIB kvsCommonLws PATHS ${OPEN_SRC_LIB_DIR} NO_DEFAULT_PATH)
#find_library (kvsWebrtcSignalingClient_LIB kvsWebrtcSignalingClient PATHS ${OPEN_SRC_LIB_DIR} NO_DEFAULT_PATH)
#find_library (kvsWebrtcClient_LIB kvsWebrtcClient PATHS ${OPEN_SRC_LIB_DIR} NO_DEFAULT_PATH)


pkg_check_modules(GST gstreamer-1.0)
if(GST_FOUND)

  if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH}:/usr/local/opt/libffi/lib/pkgconfig")
    find_library(Intl "intl" REQUIRED PATHS "/usr/local/opt/gettext/lib")
    link_directories("/usr/local/opt/gettext/lib")
  endif()

  pkg_check_modules(GLIB2 REQUIRED glib-2.0)
  pkg_check_modules(GST_APP REQUIRED gstreamer-app-1.0)
  pkg_check_modules(GOBJ2 REQUIRED gobject-2.0)
  message("gstreamer found. Will build gstreamer samples")

  set(OPEN_SRC_INCLUDE_DIRS
      ${OPEN_SRC_INCLUDE_DIRS} ${GLIB2_INCLUDE_DIRS} ${GST_INCLUDE_DIRS}
      ${GST_APP_INCLUDE_DIRS} ${GOBJ2_INCLUDE_DIRS})

  set(GST_SAMPLE_LIBRARIES ${GLIB2_LIBRARIES} ${GST_LIBRARIES}
                           ${GST_APP_LIBRARIES} ${GOBJ2_LIBRARIES} ${Intl})

  link_directories(${GLIB2_LIBRARY_DIRS})
  link_directories(${GST_LIBRARY_DIRS})
  link_directories(${GST_APP_LIBRARY_DIRS})
  link_directories(${GOBJ2_LIBRARY_DIRS})
else()
  message("gstreamer not found. Will not build gstreamer samples")
endif()


include_directories(${OPEN_SRC_INSTALL_PREFIX}/include)
include_directories(${OPEN_SRC_INCLUDE_DIRS})
link_directories(${OPEN_SRC_INSTALL_PREFIX}/lib)

add_executable(
      kvsWebrtcClientMasterGstSample
      ${CMAKE_CURRENT_SOURCE_DIR}/Common.c
      ${CMAKE_CURRENT_SOURCE_DIR}/kvsWebRTCClientMasterGstreamerSample.c
    )
    #target_link_libraries(kvsWebrtcClientMasterGstSample ${CMAKE_THREAD_LIBS_INIT} ${ssl_LIB} ${crypto_LIB} ${websockets_LIB} ${kvsCommonLws_LIB} ${kvspicUtils_LIB} ${kvsWebrtcSignalingClient_LIB} ${kvsWebrtcClient_LIB}  ${GST_SAMPLE_LIBRARIES})
    target_link_libraries(kvsWebrtcClientMasterGstSample kvsWebrtcClient kvsWebrtcSignalingClient kvsCommonLws ${GST_SAMPLE_LIBRARIES} kvspicUtils ssl crypto usrsctp websockets)

install(TARGETS kvsWebrtcClientMasterGstSample
  RUNTIME DESTINATION bin
)
