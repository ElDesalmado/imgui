
add_executable(example_sdl2_opengl3 main.cpp)

# linking with default loader
target_link_libraries(example_sdl2_opengl3
        PRIVATE
        imgui::imgui_sdl2
        imgui::imgui_opengl3
        )