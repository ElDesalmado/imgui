
add_subdirectory(glfw)
if (WIN32) # TODO: check if cross compiling
    add_subdirectory(win32)
endif()
