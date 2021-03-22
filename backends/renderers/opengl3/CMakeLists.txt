
# basic target for opengl3 renderer without a loader
add_library(imgui_opengl3_basic OBJECT
        include/imgui/opengl3/imgui_impl_opengl3.h
        imgui_impl_opengl3.cpp
        )

target_link_libraries(imgui_opengl3_basic PUBLIC core)

target_include_directories(imgui_opengl3_basic
        PUBLIC
            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
            $<INSTALL_INTERFACE:include>
        )

# renderer with glad loader
if (${USE_GLAD})
    find_package(GLAD CONFIG REQUIRED)
    add_library(imgui_opengl3_glad STATIC ${SOURCES_OPENGL3})
    target_link_libraries(imgui_opengl3_glad
            PUBLIC
                imgui_opengl3_basic
            PRIVATE
                glad::glad
            )
    target_compile_definitions(imgui_opengl3_glad PRIVATE IMGUI_IMPL_OPENGL_LOADER_GLAD)
    add_library(imgui::opengl3_glad ALIAS imgui_opengl3_glad)
endif()

# TODO: other loaders

# default loader
string(TOLOWER ${DEFAULT_LOADER} loader_default)
add_library(imgui::opengl3 ALIAS imgui_opengl3_${loader_default})
