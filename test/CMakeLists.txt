project(
    "test"
    LANGUAGES CXX
    VERSION 0.1.0
)

message("[${PROJECT_NAME}]")

set(TARGET ${PROJECT_NAME})
set(FILE_NAMES)
set(SRCS)

file(GLOB FILE_PATHS ${CMAKE_CURRENT_SOURCE_DIR}/src/*.cc)
foreach(FILE_PATH ${FILE_PATHS})
    get_filename_component(FILE_NAME ${FILE_PATH} NAME)
    list(APPEND FILE_NAMES ${FILE_NAME})
endforeach()

message(" - Target: ${TARGET}")
message(" - Source: ${FILE_NAME}")

foreach(FILE_NAME ${FILE_NAMES})
    list(APPEND SRCS src/${FILE_NAME})
endforeach()

add_executable(${TARGET} ${SRCS})
add_dependencies(${TARGET} ${DEPS} add)

if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    target_compile_options(${TARGET} PRIVATE /utf-8)
endif()

target_include_directories(${TARGET} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include ${CMAKE_BINARY_DIR}/install/include ${CMAKE_SOURCE_DIR}/add/include)
target_link_directories(${TARGET} PRIVATE ${CMAKE_BINARY_DIR}/lib ${CMAKE_BINARY_DIR}/install/lib)
target_link_libraries(${TARGET} PRIVATE ${LIBS})