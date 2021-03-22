
add_library(imgui_win32 STATIC
        include/imgui/win32/imgui_impl_win32.h
        imgui_impl_win32.cpp
        )
target_link_libraries(imgui_win32
        PUBLIC
            core
        )

target_include_directories(imgui_win32
        PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
        )

add_library(imgui::win32 ALIAS imgui_win32)