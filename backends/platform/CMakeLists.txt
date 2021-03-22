
if (WIN32) # TODO: check if cross compiling
    add_subdirectory(win32)
endif()
add_subdirectory(glfw)
add_subdirectory(sdl2)