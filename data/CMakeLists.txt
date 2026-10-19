add_custom_target(
    deploy_data ALL
    COMMAND ${CMAKE_COMMAND} -E copy_directory "${CMAKE_CURRENT_LIST_DIR}" "${CMAKE_BINARY_DIR}/data"
)

add_subdirectory(shaders)