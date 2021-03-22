
add_executable(example_glfw_opengl3 main.cpp)

# linking with default loader
target_link_libraries(example_glfw_opengl3
        PRIVATE
        imgui::glfw
        imgui::opengl3
        )