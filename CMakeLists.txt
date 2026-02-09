cmake_minimum_required(VERSION 3.19)

project(fht-composior-ipc VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set(CMAKE_INSTALL_PREFIX "/")

set(DISTRIBUTOR "Unset" CACHE STRING "Distributor")
set(INSTALL_LIBDIR "usr/lib/fht-compositor" CACHE STRING "Library install dir")
set(INSTALL_QMLDIR "usr/lib/qt6/qml" CACHE STRING "QML install dir")

# QML plugin setup
# Mostly copied from Caelestia and Sleex.
find_package(Qt6 REQUIRED COMPONENTS Core Qml Gui Quick)
find_package(PkgConfig REQUIRED)

set(QT_QML_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/qml")
qt_standard_project_setup(REQUIRES 6.7)
# Helper function to declare a QML module.
# From caelestia-shell!
function(qml_module arg_TARGET)
    cmake_parse_arguments(PARSE_ARGV 1 arg "" "URI" "SOURCES;LIBRARIES")

    qt_add_qml_module(${arg_TARGET}
        URI ${arg_URI}
        VERSION ${VERSION}
        SOURCES ${arg_SOURCES}
    )

    qt_query_qml_module(${arg_TARGET}
        URI module_uri
        VERSION module_version
        PLUGIN_TARGET module_plugin_target
        TARGET_PATH module_target_path
        QMLDIR module_qmldir
        TYPEINFO module_typeinfo
    )

    message(STATUS "Created QML module ${module_uri}, version ${module_version}")

    set(module_dir "${INSTALL_QMLDIR}/${module_target_path}")
    install(TARGETS ${arg_TARGET} LIBRARY DESTINATION "${module_dir}" RUNTIME DESTINATION "${module_dir}")
    install(TARGETS "${module_plugin_target}" LIBRARY DESTINATION "${module_dir}" RUNTIME DESTINATION "${module_dir}")
    install(FILES "${module_qmldir}" DESTINATION "${module_dir}")
    install(FILES "${module_typeinfo}" DESTINATION "${module_dir}")

    target_link_libraries(${arg_TARGET} PRIVATE Qt::Core Qt::Qml ${arg_LIBRARIES})
endfunction()

add_subdirectory(src/)
