project(
    sub-project
    LANGUAGES CXX
    VERSION 0.1.0
)

message("[${PROJECT_NAME}]")

set(FILE_NAMES)
set(SRCS)

file(GLOB FILE_PATHS ${PROJECT_SOURCE_DIR}/src/*.cpp)
foreach(FILE_PATH ${FILE_PATHS})
    get_filename_component(FILE_NAME ${FILE_PATH} NAME)
    list(APPEND FILE_NAMES ${FILE_NAME})
endforeach()

message(" - Source: ${FILE_NAMES}")

foreach(FILE_NAME ${FILE_NAMES})
    list(APPEND SRCS src/${FILE_NAME})
endforeach()

add_executable(${PROJECT_NAME} ${SRCS})
add_dependencies(${PROJECT_NAME} ${DEPS})

target_include_directories(${PROJECT_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/include)
# ExternalProject
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_BINARY_DIR}/install/include)
# FetchContent
foreach(DEP ${DEPS})
    target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_BINARY_DIR}/_deps/${DEP}-src/include)
endforeach()
# ExternalProject
target_link_directories(${PROJECT_NAME} PRIVATE ${CMAKE_BINARY_DIR}/install/lib)
# FetchContent
target_link_directories(${PROJECT_NAME} PRIVATE ${CMAKE_BINARY_DIR}/lib)
target_link_libraries(${PROJECT_NAME} PRIVATE ${LIBS})

if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    target_compile_options(${PROJECT_NAME} PRIVATE /utf-8)
endif()

if(CMAKE_BUILD_TYPE STREQUAL Debug)
    target_compile_options(${PROJECT_NAME} PRIVATE $<$<CXX_COMPILER_ID:MSVC>:/Zi /W4 /Wall /Od /utf-8> $<$<CXX_COMPILER_ID:GNU>:-g -Wall -Wextra -O0>)
elseif (CMAKE_BUILD_TYPE STREQUAL Release)
    target_compile_options(${PROJECT_NAME} PRIVATE $<$<CXX_COMPILER_ID:MSVC>:/W4 /Wall /utf-8> $<$<CXX_COMPILER_ID:GNU>:-Wall -Wextra>)
endif()