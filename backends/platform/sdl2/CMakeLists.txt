
# assumes that the target has been imported
if (TARGET SDL2::SDL2)
    add_library(imgui_sdl2 STATIC
            include/imgui/sdl2/imgui_impl_sdl.h
            imgui_impl_sdl.cpp
            )
    target_link_libraries(imgui_sdl2
            PUBLIC
                core
            PUBLIC # TODO: Private. example includes <SDL2.h> so it needs to be PUBLIC for now
                SDL2::SDL2
            )
    target_include_directories(imgui_sdl2
            PUBLIC
            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
            $<INSTALL_INTERFACE:include>
            )

    # TODO: another approach? otherwise undefined reference to 'WinMain'
    target_compile_definitions(imgui_sdl2 PUBLIC SDL_MAIN_HANDLED)
    add_library(imgui::imgui_sdl2 ALIAS imgui_sdl2)
    install_target(imgui_sdl2 ${PROJECT_NAME}Targets)
endif()