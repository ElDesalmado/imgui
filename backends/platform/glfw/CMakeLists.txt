
# assumes that the target has been imported
if (TARGET glfw)
    add_library(imgui_glfw STATIC
            include/imgui/glfw/imgui_impl_glfw.h
            imgui_impl_glfw.cpp
            )
    target_link_libraries(imgui_glfw
            PUBLIC
                core
            PRIVATE
                glfw
            )
    target_include_directories(imgui_glfw
            PUBLIC
                $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
                $<INSTALL_INTERFACE:include>
            )
    add_library(imgui::glfw ALIAS imgui_glfw)
endif()