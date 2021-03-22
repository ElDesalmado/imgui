﻿
function(install_target TARGET EXPORT_NAME)
    install(TARGETS ${TARGET}
            EXPORT ${EXPORT_NAME}
            LIBRARY DESTINATION lib
            ARCHIVE DESTINATION lib
            RUNTIME DESTINATION bin
            )
    install(DIRECTORY $<TARGET_PROPERTY:${TARGET},SOURCE_DIR>/include
            DESTINATION ${CMAKE_INSTALL_PREFIX}
            )
endfunction()
