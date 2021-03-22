cmake_minimum_required(VERSION 3.7.2 FATAL_ERROR)

project(imgui
        LANGUAGES CXX C
        VERSION 1.83.0
        )

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY bin)

include(CMakeDependentOption)
list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# custom scripts in ./cmake
include(loaders_and_platforms)
include(install_target)

# add options for supported loaders
list_loaders_options(LOADERS GLAD
        OUT AVAILABLE_LOADERS)

get_default_loader(default_loader
        LIST_LOADERS ${AVAILABLE_LOADERS})

set(DEFAULT_LOADER "${default_loader}" CACHE STRING "Default OpenGL loader to be used in backends")
set_property(CACHE DEFAULT_LOADER PROPERTY STRINGS ${AVAILABLE_LOADERS})

# assert default loader
if (${DEFAULT_LOADER} STREQUAL "NONE")
    message(FATAL_ERROR "No default loader specified or detected!")
endif()

# TODO: fix this message
message(STATUS "Using default loader: ${DEFAULT_LOADER}")


# add options for supported platforms
list_platforms_options(PLATFORMS
        GLFW3
        SDL2
        )

# TODO: default platform?
# core library does not assume a specific loader.
add_library(core STATIC
        include/imgui/imgui.h
        src/imgui.cpp
        src/imgui_internal.h
        src/imgui_draw.cpp
        src/imgui_tables.cpp
        src/imgui_widgets.cpp
        src/imgui_demo.cpp # is it necessary to have here?
        )
add_library(imgui::core ALIAS core)

if(WIN32)
    target_link_libraries(core PRIVATE Imm32)
endif()

target_include_directories(core
        PUBLIC
            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
            $<INSTALL_INTERFACE:include>
        PRIVATE
            src
        )

# TODO: this should not be propagated to user's libs
target_compile_features(core PUBLIC cxx_std_11)

# compile-time preprocessor should be defined via toolchain file using cmake
# to use imconfig.h explicitly define IMGUI_INCLUDE_IMCONFIG_H
target_compile_definitions(core PUBLIC IMGUI_DISABLE_INCLUDE_IMCONFIG_H)
set_target_properties(core PROPERTIES CXX_EXTENSIONS OFF)

# backends
add_subdirectory(backends)

# examples
add_subdirectory(examples)

# general installation
include(CMakePackageConfigHelpers)

# PROJECT_VERSION is used by default
write_basic_package_version_file(${PROJECT_NAME}ConfigVersion.cmake
        COMPATIBILITY SameMajorVersion # TODO: check compatibility
        )
configure_package_config_file(cmake/Config.cmake.in ${PROJECT_NAME}Config.cmake
        INSTALL_DESTINATION lib/cmake/${PROJECT_NAME}
        )

install_target(core ${PROJECT_NAME}Targets)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
        ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
        DESTINATION lib/cmake/${PROJECT_NAME}
        )
install(EXPORT ${PROJECT_NAME}Targets
        FILE ${PROJECT_NAME}Targets.cmake
        NAMESPACE imgui::
        COMPONENT dev
        DESTINATION lib/cmake/${PROJECT_NAME}
        )

# packaging
set(CPACK_RESOURCE_FILE_LICENSE "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE.txt")
# set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md") # TODO: where is README?

include(CPack)