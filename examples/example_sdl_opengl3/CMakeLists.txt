
add_executable(example_sdl2_opengl3 main.cpp)

# linking with default loader
target_link_libraries(example_sdl2_opengl3
        PRIVATE
        imgui::sdl2
        imgui::opengl3
        )