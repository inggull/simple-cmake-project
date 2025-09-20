cmake_minimum_required(VERSION 3.11)

set(CMAKE_CXX_STANDARD 17)  # 프로젝트를 빌드할 때 컴파일러에 전달할 C++ 언어 버전을 설정
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)  # 프로젝트 실행 파일을 빌드할 경로를 설정
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)  # 프로젝트 동적 라이브러리를 빌드할 경로를 설정
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)  # 프로젝트 정적 라이브러리를 빌드할 경로를 설정
set(DEPS)
set(LIBS)

project(
    main_project
    LANGUAGES CXX
    VERSION 0.1.0
    HOMEPAGE_URL https://github.com/inggull/simple-cmake-project.git
    DESCRIPTION "A Simple CMake Project"
)

message("[Compiler]")
message(" - Path : ${CMAKE_CXX_COMPILER}")
message(" - ID : ${CMAKE_CXX_COMPILER_ID}")
message(" - Version: ${CMAKE_CXX_COMPILER_VERSION}")

message("[${CMAKE_PROJECT_NAME}]")

set(FILE_NAMES)
set(SRCS)

file(GLOB FILE_PATHS ${CMAKE_SOURCE_DIR}/src/*.cc)
foreach(FILE_PATH ${FILE_PATHS})
    get_filename_component(FILE_NAME ${FILE_PATH} NAME)
    list(APPEND FILE_NAMES ${FILE_NAME})
endforeach()

message(" - source: ${FILE_NAME}")

foreach(FILE_NAME ${FILE_NAMES})
    list(APPEND SRCS src/${FILE_NAME})
endforeach()

# 빌드되어야 하는 순서로 프로젝트를 추가
include(Dependency.cmake)
# 메인 프로젝트의 변수는 서브 프로젝트에도 전파된다
add_subdirectory(add)
add_subdirectory(sub_project)

# src/main.cc를 사용하여 `CMAKE_PROJECT_NAME`이라는 이름으로 실행 파일을 추가
add_executable(${CMAKE_PROJECT_NAME} ${SRCS})

# 의존성이 먼저 빌드될 수 있게 관계 설정
add_dependencies(${CMAKE_PROJECT_NAME} ${DEPS} add)

# 헤더 파일 경로를 연결
target_include_directories(${CMAKE_PROJECT_NAME} PUBLIC ${CMAKE_SOURCE_DIR}/include ${CMAKE_BINARY_DIR}/install/include ${CMAKE_SOURCE_DIR}/add/include)
foreach(DEP ${DEPS})
    target_include_directories(${CMAKE_PROJECT_NAME} PRIVATE ${CMAKE_BINARY_DIR}/_deps/${DEP}-src/include)
endforeach()

# 라이브러리 파일 경로를 연결
target_link_directories(${CMAKE_PROJECT_NAME} PUBLIC $${CMAKE_BINARY_DIR}/lib ${CMAKE_BINARY_DIR}/install/lib)

# 실행 파일에 링크할 라이브러리를 추가
target_link_libraries(${CMAKE_PROJECT_NAME} ${LIBS})

if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC /utf-8)  # MSVC의 인코딩 방식을 UTF-8로 강제하는 컴파일 옵션을 추가
endif()

# 따로 설정하지 않는다면 디버그를 기본 빌드 타입으로 설정
# if(NOT CMAKE_BUILD_TYPE)
#     set(CMAKE_BUILD_TYPE Debug)
# endif()
#
# 빌드 타입과 컴파일러에 따른 컴파일 옵션을 설정
# if(CMAKE_BUILD_TYPE STREQUAL Debug)
#     target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC $<$<CXX_COMPILER_ID:MSVC>:/Zi /W4 /Wall /WX /Od /utf-8> $<$<CXX_COMPILER_ID:GNU>:-g -Wall -Wextra -Werror -O0>)
# elseif (CMAKE_BUILD_TYPE STREQUAL Release)
#    target_compile_options(${CMAKE_PROJECT_NAME} PUBLIC $<$<CXX_COMPILER_ID:MSVC>:/W4 /Wall /utf-8> $<$<CXX_COMPILER_ID:GNU>:-Wall -Wextra>)
# endif()