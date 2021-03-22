cmake_minimum_required(VERSION 3.7.2 FATAL_ERROR)

project(imgui
        LANGUAGES CXX C
        VERSION 1.83.0
        )

# TODO: macro for a list of loaders and default loader deduction
# TODO: naming conventions
# TODO: option for default loader
set(DEFAULT_LOADER "GLAD" CACHE STRING "Default OpenGL loader to be used in backends")
set_property(CACHE DEFAULT_LOADER PROPERTY STRINGS GLAD)

message(STATUS "Using default loader: ${DEFAULT_LOADER}")

include(CMakeDependentOption)

cmake_dependent_option(USE_GLAD "Use GLAD loader" ON
        "${DEFAULT_LOADER} STREQUAL GLAD" OFF)
if (${USE_GLAD})
    message(STATUS "Using loader: GLAD")
endif()

# list of loaders:

# USE_GLAD
# TODO: allow custom loaders

add_library(core STATIC
        include/imgui/imgui.h
        src/imgui.cpp
        src/imgui_internal.h
        src/imgui_draw.cpp
        src/imgui_tables.cpp
        src/imgui_widgets.cpp
        src/imgui_demo.cpp # is it necessary to have here?
        )

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

target_compile_features(core PUBLIC cxx_std_11)

# compile-time preprocessor should be defined via toolchain file using cmake
# to use imconfig.h explicitly define IMGUI_INCLUDE_IMCONFIG_H
target_compile_definitions(core PUBLIC IMGUI_DISABLE_INCLUDE_IMCONFIG_H)
set_target_properties(core PROPERTIES CXX_EXTENSIONS OFF)

add_library(imgui::core ALIAS core)

# backends
add_subdirectory(backends)

# TODO: each example corresponds to a specific backend. Consider moving each example to a corresponding backend folder
# examples
add_subdirectory(examples)

# demo
add_subdirectory(demo)