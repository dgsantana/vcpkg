cmake_minimum_required(VERSION 3.0)

include(GNUInstallDirs)

project(libfaac C)

if(MSVC)
    set(CMAKE_DEBUG_POSTFIX "d")
    add_definitions(-D_CRT_SECURE_NO_DEPRECATE)
    add_definitions(-D_CRT_NONSTDC_NO_DEPRECATE)
endif()

option(USE_DRM "Use DRM sysyem" OFF)
#option(BUILD_SHARED_LIBS "Build shared libraries" ON)

# List the header files
set(HEADERS 
    include/faac.h
    include/faaccfg.h
)

# List the source files
set(SRCS
    libfaac/bitstream.c
    libfaac/bitstream.h
    libfaac/blockswitch.c
    libfaac/blockswitch.h
    libfaac/channels.c
    libfaac/channels.h
    libfaac/coder.h
    libfaac/fft.c
    libfaac/fft.h
    libfaac/filtbank.c
    libfaac/filtbank.h
    libfaac/frame.c
    libfaac/frame.h
    libfaac/huff2.c
    libfaac/huff2.h
    libfaac/huffdata.c
    libfaac/huffdata.h
    libfaac/quantize.c
    libfaac/quantize.h
    libfaac/stereo.c
    libfaac/stereo.h
    libfaac/tns.c
    libfaac/tns.h
    libfaac/util.c
    libfaac/util.h
)

if(USE_DRM)
    list(APPEND SRCS
        libfaac/kiss_fft/kiss_fft.c
        libfaac/kiss_fft/kiss_fft.h
        libfaac/kiss_fft/kiss_fftr.c
        libfaac/kiss_fft/kiss_fftr.h
        libfaac/kiss_fft/_kiss_fft_guts.h
    )
endif(USE_DRM)

add_library(libfaac ${SRCS})

if(USE_DRM)
    target_compile_definitions(libfaac PRIVATE -DDRM)
endif(USE_DRM)
#if(BUILD_SHARED_LIBS)
#    target_compile_definitions(libfaac PRIVATE -DFAACAPI)
#endif()

target_link_libraries(libfaac ${ZLIB_LIBRARIES})
target_include_directories(libfaac BEFORE PUBLIC
    $<BUILD_INTERFACE:${HEADERS}>
    $<INSTALL_INTERFACE:include>
    )

install(TARGETS libfaac
        COMPONENT runtime
        RUNTIME DESTINATION "${CMAKE_INSTALL_BINDIR}" COMPONENT bin
        LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}" COMPONENT shlib
        ARCHIVE DESTINATION "${CMAKE_INSTALL_LIBDIR}" COMPONENT lib)

install(FILES ${HEADERS} DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/libfaac)