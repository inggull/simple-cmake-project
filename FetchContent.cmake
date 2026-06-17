# 3.11 버전에 추가된 FetchContent는 ExternalProject와 달리 구성 시에 외부 프로젝트를 일단 클론해서
# 소스 파일 경로를 서브 디렉토리로 추가하는 방식으로 프로젝트와 통합한다
# FetchContent 관련 명령어 셋을 추가한다
include(FetchContent)

# 클론해올 외부 프로젝트 이름과 여러 옵션들을 지정한다
FetchContent_Declare(
    spdlog
    GIT_REPOSITORY https://github.com/gabime/spdlog.git
    GIT_TAG v1.x
    GIT_SHALLOW 1
)

# 구성 시에 외부 프로젝트를 클론하여 소스 파일 경로를 서브 디렉토리로 추가하고
# 외부 프로젝트 이름을 타겟으로 지정한다
# 클론된 외부 프로젝트의 소스 파일 경로: ${CMAKE_BINARY_DIR}/_deps/<외부 프로젝트 이름>-src
# 클론된 외부 프로젝트의 빌드 경로: ${CMAKE_BINARY_DIR}/_deps/<외부 프로젝트 이름>-build
FetchContent_MakeAvailable(spdlog)

# FetchContent는 외부 프로젝트의 타겟에 컴파일러 인수를 전달하는 등의 설정이 가능하다
# ExternalProject는 CMAKE_ARGS에 `-D CMAKE_CXX_FLAGS=/utf-8`로 인수를 전달하거나
# 소스 파일 경로를 서브 디렉토리로 추가하여 프로젝트를 재정의 하는 방식으로 타겟에 대한 설정이 가능하다
if (CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    target_compile_options(spdlog PRIVATE /utf-8)
endif()

# 의존성 리스트 및 라이브러리 파일 리스트를 추가한다
list(APPEND DEPS spdlog)
list(APPEND LIBS spdlog$<$<CONFIG:Debug>:d>)