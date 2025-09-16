project(
    "Test"
    LANGUAGES CXX
    VERSION 0.1.0
    HOMEPAGE_URL ""
    DESCRIPTION ""
)

message("[${PROJECT_NAME}]")

set(TARGET test)
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

if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    message(" - MSVC의 인코딩 방식을 UTF-8로 강제하는 컴파일 옵션을 추가")
    target_compile_options(${TARGET} PRIVATE /utf-8)
endif()

target_include_directories(${TARGET} PRIVATE ${CMAKE_SOURCE_DIR}/include ${CMAKE_BINARY_DIR}/install/include)

target_link_directories(${TARGET} PRIVATE ${CMAKE_SOURCE_DIR}/lib ${CMAKE_BINARY_DIR}/install/lib)

add_dependencies(${TARGET} ${DEPS} add)

target_link_libraries(${TARGET} PRIVATE ${LIBS} add)