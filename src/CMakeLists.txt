qml_module(fhtc URI Fhtc
    SOURCES
        ipc.hpp ipc.cpp
        workspaces.hpp workspaces.cpp
        monitors.hpp monitors.cpp
        plugin.cpp
)

target_link_libraries(fhtc PRIVATE Qt6::Core Qt6::Qml Qt6::Network)
