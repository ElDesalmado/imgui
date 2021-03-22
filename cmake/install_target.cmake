
function(install_target TARGET EXPORT_NAME)
    install(TARGETS ${TARGET}
            EXPORT ${EXPORT_NAME}
            COMPONENT dev
            LIBRARY DESTINATION lib
            ARCHIVE DESTINATION lib
            RUNTIME DESTINATION bin
            )
    get_target_property(type ${TARGET} TYPE)
    if (NOT ${type} STREQUAL INTERFACE_LIBRARY)
        install(DIRECTORY $<TARGET_PROPERTY:${TARGET},SOURCE_DIR>/include
                DESTINATION ${CMAKE_INSTALL_PREFIX}
                )
    endif()
endfunction()
