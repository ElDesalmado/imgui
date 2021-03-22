
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
install_target(imgui_opengl3_basic ${PROJECT_NAME}Targets)

# renderer with glad loader
if (${USE_GLAD})
    add_library(imgui_opengl3_glad STATIC ${SOURCES_OPENGL3})
    target_link_libraries(imgui_opengl3_glad
            PUBLIC
                imgui_opengl3_basic
            PRIVATE
                glad::glad
            )
    target_compile_definitions(imgui_opengl3_glad PRIVATE IMGUI_IMPL_OPENGL_LOADER_GLAD)
    add_library(imgui::imgui_opengl3_glad ALIAS imgui_opengl3_glad)
    install_target(imgui_opengl3_glad ${PROJECT_NAME}Targets)
endif()

# TODO: other loaders

# TODO: check if DEFAULT_LOADER is set
# default loader
string(TOLOWER ${DEFAULT_LOADER} loader_default)
add_library(imgui_opengl3 INTERFACE)
add_library(imgui::imgui_opengl3 ALIAS imgui_opengl3)

target_link_libraries(imgui_opengl3 INTERFACE imgui_opengl3_${loader_default})
install_target(imgui_opengl3 ${PROJECT_NAME}Targets)
