project(
    add
    LANGUAGES C
    VERSION 0.1.0
)

message("[${PROJECT_NAME}]")

set(FILE_NAMES)
set(SRCS)

file(GLOB FILE_PATHS ${PROJECT_SOURCE_DIR}/src/*.c)
foreach(FILE_PATH ${FILE_PATHS})
    get_filename_component(FILE_NAME ${FILE_PATH} NAME)
    list(APPEND FILE_NAMES ${FILE_NAME})
endforeach()

message(" - Source: ${FILE_NAMES}")

foreach(FILE_NAME ${FILE_NAMES})
    list(APPEND SRCS src/${FILE_NAME})
endforeach()

add_library(${PROJECT_NAME} STATIC ${SRCS})

# PUBLIC을 사용하면 이 프로젝트를 참조하는 다른 타겟의 헤더 파일 경로에도 자동으로 적용된다
target_include_directories(${PROJECT_NAME} PUBLIC ${PROJECT_SOURCE_DIR}/include)

if (CMAKE_C_COMPILER_ID STREQUAL "MSVC")
    target_compile_options(${PROJECT_NAME} PRIVATE /utf-8)
endif()

if(CMAKE_BUILD_TYPE STREQUAL Debug)
    target_compile_options(${PROJECT_NAME} PRIVATE $<$<C_COMPILER_ID:MSVC>:/Zi /W4 /Wall /WX /Od /utf-8> $<$<C_COMPILER_ID:GNU>:-g -Wall -Wextra -O0>)
elseif (CMAKE_BUILD_TYPE STREQUAL Release)
    target_compile_options(${PROJECT_NAME} PRIVATE $<$<C_COMPILER_ID:MSVC>:/W4 /Wall /utf-8> $<$<C_COMPILER_ID:GNU>:-Wall -Wextra>)
endif()

# PARENT_SCOPE: 상위 프로젝트의 변수를 지칭
set(DEPS ${DEPS} add PARENT_SCOPE)
set(LIBS ${LIBS} add PARENT_SCOPE)