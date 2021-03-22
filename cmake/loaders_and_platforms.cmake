function(add_loader_option LOADER)
    # try to find package
    find_package(${LOADER})

    # TODO: fix this. User should be able to set FALSE for a particular loader
    # if found enable loader by default
    cmake_dependent_option(USE_${LOADER} "Use ${LOADER} loader" ON
            "${LOADER}_FOUND" OFF)

    # TODO: search for config first
    # if enabled, assert that package has been found
    if (USE_${LOADER})
        find_package(${LOADER} REQUIRED)
        message(STATUS "Using loader: ${LOADER}")
    endif()
endfunction()

function(list_loaders_options)
    set(options "")
    set(oneValueArgs OUT)
    set(multiValueArgs LOADERS)
    cmake_parse_arguments("" "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    foreach(LOADER ${_LOADERS})
        add_loader_option(${LOADER})
        if (USE_${LOADER})
            list(APPEND ${_OUT} ${LOADER})
        endif()
    endforeach()

    set(${_OUT} ${${_OUT}} PARENT_SCOPE)
endfunction()

function(add_platform_option PLATFORM)

    # try to find package
    find_package(${PLATFORM})

    # TODO: fix this. User should be able to set FALSE for a particular loader
    # if found enable loader by default
    cmake_dependent_option(USE_${PLATFORM} "Use ${PLATFORM} platform" ON
            "${PLATFORM}_FOUND" OFF)

    # TODO: search for config first
    # if enabled, assert that package has been found
    if (USE_${PLATFORM})
        find_package(${PLATFORM} REQUIRED)
        message(STATUS "Using platform: ${PLATFORM}")
    endif()
endfunction()

function(list_platforms_options)
    set(options "")
    set(oneValueArgs OUT)
    set(multiValueArgs PLATFORMS)
    cmake_parse_arguments("" "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    foreach(PLATFORM ${_PLATFORMS})
        add_platform_option(${PLATFORM})
        if (USE_${PLATFORM})
            list(APPEND ${_OUT} ${PLATFORM})
        endif()
    endforeach()

    set(${_OUT} ${${_OUT}} PARENT_SCOPE)
endfunction()


function(get_default_loader OUT_LOADER)
    set(options "")
    set(oneValueArgs "")
    set(multiValueArgs "LIST_LOADERS")
    cmake_parse_arguments("" "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    # default error value
    set(OUT "NONE")
    # TODO: default loader for android/GLES (LOADER_NONE)
    # TODO: default loader for emscripten (LOADER_NONE)


    # if loaders list is not empty, get the first loader as default
    if (_LIST_LOADERS)
        list(GET _LIST_LOADERS 0 OUT)
    else()
        # TODO: try to deduce loader somehow
    endif()

    set(${OUT_LOADER} "${OUT}" PARENT_SCOPE)
endfunction()