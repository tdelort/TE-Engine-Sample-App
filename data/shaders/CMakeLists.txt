# find Powershell executable
find_program(POWERSHELL_PATH NAMES pwsh)

add_custom_target(
    build_shaders ALL
    COMMAND ${POWERSHELL_PATH}  
        "${CMAKE_CURRENT_LIST_DIR}/compile_all.ps1" 
    WORKING_DIRECTORY ${CMAKE_CURRENT_LIST_DIR}/
)
add_dependencies(deploy_data build_shaders)
