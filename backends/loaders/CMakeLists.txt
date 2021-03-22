
# basic target object with undefined preprocessor
set(SOURCES_OPENGL3
        opengl3/include/imgui/opengl3/imgui_impl_opengl3.h
        opengl3/imgui_impl_opengl3.cpp
        )
set(INCLUDE_OPENGL3 opengl3/include)

if (${USE_GLAD})
    find_package(GLAD CONFIG REQUIRED)
    add_library(imgui_opengl3_glad STATIC ${SOURCES_OPENGL3})
    target_link_libraries(imgui_opengl3_glad
            PUBLIC
                core
            PRIVATE
                glad::glad
            )
    target_include_directories(imgui_opengl3_glad
            PUBLIC
            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/${INCLUDE_OPENGL3}>
            $<INSTALL_INTERFACE:include>
            )
    target_compile_definitions(imgui_opengl3_glad PRIVATE IMGUI_IMPL_OPENGL_LOADER_GLAD)
    add_library(imgui::opengl3_glad ALIAS imgui_opengl3_glad)
endif()

# default loader
string(TOLOWER ${DEFAULT_LOADER} loader_default)
add_library(imgui::opengl3 ALIAS imgui_opengl3_${loader_default})