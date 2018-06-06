include(vcpkg_common_functions)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO dropbox/json11
    REF ec4e45219af1d7cde3d58b49ed762376fccf1ace
    SHA512 2129e048d8dee027dc1ba789d9901e017b7d698465e15236802ef68639161e1cc7c8665d5f50079333801717fd41ffbe2cb90fa2165b9a85629e8ced8f2b3cd8
    HEAD_REF master
)

if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    message(STATUS "Warning: Dynamic building not supported.")
    set(VCPKG_LIBRARY_LINKAGE static)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS -DJSON11_WITH_CMAKE_PACKAGE:BOOL=ON
            -DBUILD_STATIC_LIBS:BOOL=ON
            -DBUILD_SHARED_LIBS:BOOL=OFF
            -DJSON11_BUILD_TESTS:BOOL=OFF
            -DJSON11_ENABLE_DR1467_CANARY:BOOL=OFF
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/json11)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/json11/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/json11/copyright)
