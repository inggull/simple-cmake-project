cmake_minimum_required(VERSION 3.10)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(DEPS)
set(LIBS)

project(
    "Simple CMake Project"
    LANGUAGES CXX
    VERSION 0.1.0
    HOMEPAGE_URL "https://github.com/inggull/simple-cmake-project.git"
    DESCRIPTION "A simple CMake project while studying CMake"
)
message("[Compiler]")
message(" - Path : ${CMAKE_CXX_COMPILER}")
message(" - ID : ${CMAKE_CXX_COMPILER_ID}")
message(" - Version: ${CMAKE_CXX_COMPILER_VERSION}")

message("[${CMAKE_PROJECT_NAME}]")

set(CMAKE_TARGET "simple_cmake_project")
set(CMAKE_FILE_NAMES)
set(CMAKE_SRCS)

file(GLOB CMAKE_FILE_PATHS ${CMAKE_SOURCE_DIR}/src/*.cc)
foreach(CMAKE_FILE_PATH ${CMAKE_FILE_PATHS})
    get_filename_component(CMAKE_FILE_NAME ${CMAKE_FILE_PATH} NAME)
    list(APPEND CMAKE_FILE_NAMES ${CMAKE_FILE_NAME})
endforeach()

message(" - Target: ${CMAKE_TARGET}")
message(" - source: ${CMAKE_FILE_NAME}")

foreach(CMAKE_FILE_NAME ${CMAKE_FILE_NAMES})
    list(APPEND CMAKE_SRCS src/${CMAKE_FILE_NAME})
endforeach()

# 빌드되어야 하는 순서로 프로젝트를 추가
include(Dependency.cmake)
add_subdirectory(add)
add_subdirectory(test)

# src/main.cc를 사용하여 ${CMAKE_TARGET}이라는 이름으로 실행 파일을 추가
add_executable(${CMAKE_TARGET} ${CMAKE_SRCS})

# 의존성이 먼저 빌드될 수 있게 관계 설정
add_dependencies(${CMAKE_TARGET} ${DEPS} add)

# 헤더 파일 경로를 연결
target_include_directories(${CMAKE_TARGET} PUBLIC ${CMAKE_SOURCE_DIR}/include ${CMAKE_BINARY_DIR}/install/include ${CMAKE_SOURCE_DIR}/add/include)

# 라이브러리 파일 경로를 연결
target_link_directories(${CMAKE_TARGET} PUBLIC $${CMAKE_BINARY_DIR}/lib ${CMAKE_BINARY_DIR}/install/lib)

# 실행 파일에 링크할 라이브러리를 추가
target_link_libraries(${CMAKE_TARGET} ${LIBS})

if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    target_compile_options(${CMAKE_TARGET} PUBLIC /utf-8)  # MSVC의 인코딩 방식을 UTF-8로 강제하는 컴파일 옵션을 추가
endif()

# 따로 설정하지 않는다면 디버그를 기본 빌드 타입으로 설정
# if(NOT CMAKE_BUILD_TYPE)
#     set(CMAKE_BUILD_TYPE Debug)
# endif()
#
# 빌드 타입과 컴파일러에 따른 컴파일 옵션을 설정
# if(CMAKE_BUILD_TYPE STREQUAL Debug)
#     target_compile_options(${CMAKE_TARGET} PUBLIC $<$<CXX_COMPILER_ID:MSVC>:/Zi /W4 /Wall /WX /Od /utf-8> $<$<CXX_COMPILER_ID:GNU>:-g -Wall -Wextra -Werror -O0>)
# elseif (CMAKE_BUILD_TYPE STREQUAL Release)
#    target_compile_options(${CMAKE_TARGET} PUBLIC $<$<CXX_COMPILER_ID:MSVC>:/W4 /Wall /utf-8> $<$<CXX_COMPILER_ID:GNU>:-Wall -Wextra>)
# endif()