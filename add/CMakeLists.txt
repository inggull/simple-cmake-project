project(
    "add"
    LANGUAGES CXX
    VERSION 0.1.0
)

message("[${PROJECT_NAME}]")

set(FILE_NAMES)
set(SRCS)

file(GLOB FILE_PATHS ${PROJECT_SOURCE_DIR}/src/*.cc)
foreach(FILE_PATH ${FILE_PATHS})
    get_filename_component(FILE_NAME ${FILE_PATH} NAME)
    list(APPEND FILE_NAMES ${FILE_NAME})
endforeach()

message(" - Source: ${FILE_NAME}")

foreach(FILE_NAME ${FILE_NAMES})
    list(APPEND SRCS src/${FILE_NAME})
endforeach()

add_library(${PROJECT_NAME} STATIC ${SRCS})

target_include_directories(${PROJECT_NAME} PRIVATE ${PROJECT_SOURCE_DIR}/include ${CMAKE_BINARY_DIR}/install/include)
foreach(DEP ${DEPS})
    target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_BINARY_DIR}/_deps/${DEP}-src/include)
endforeach()

if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    target_compile_options(${PROJECT_NAME} PRIVATE /utf-8)
endif()

# PARENT_SCOPE: 상위 프로젝트의 변수를 지칭
set(DEPS ${DEPS} add PARENT_SCOPE)
set(LIBS ${LIBS} add PARENT_SCOPE)