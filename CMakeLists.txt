cmake_minimum_required(VERSION 3.20)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
project(TESampleApp VERSION 0.1.0)

add_executable(TESampleApp main.cpp )

target_sources(TESampleApp
    PRIVATE
)

target_compile_features(TESampleApp PUBLIC cxx_std_20)
set_target_properties(
    TESampleApp PROPERTIES

    CMAKE_CXX_STANDARD 20
    CMAKE_CXX_STANDARD_REQUIRED TRUE
    CMAKE_CXX_SCAN_FOR_MODULES ON
    CMAKE_CXX_EXTENSIONS OFF

    DEBUG_POSTFIX "D"
    RELWITHDEBINFO_POSTFIX "RD"
)

target_compile_definitions(TESampleApp PRIVATE
  $<$<CONFIG:Debug>:_DEBUG>
)

target_link_options(TESampleApp PRIVATE
  $<$<CONFIG:Debug>:-DEBUG>
)

set(TE_ENGINE_PROJECT_PATH libraries/TE-Engine)
add_subdirectory(${TE_ENGINE_PROJECT_PATH})

target_link_libraries(TESampleApp
    PRIVATE 
        TEEngine
)

# copies compile_commands on build from build/{$presetName}/ to ./
add_custom_target(
    copy-compile-commands ALL
    ${CMAKE_COMMAND} -E copy_if_different ${CMAKE_BINARY_DIR}/compile_commands.json ${CMAKE_CURRENT_LIST_DIR}
)

# add data subdir 
add_subdirectory(data)
