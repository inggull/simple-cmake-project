# ExternalProject 관련 명령어 셋 추가
include(ExternalProject)

ExternalProject_Add(
    dep-spdlog  # 외부 프로젝트 이름
    GIT_REPOSITORY "https://github.com/gabime/spdlog.git"
    GIT_TAG "v1.x"  # 특정 브랜치나 태그
    GIT_SHALLOW 1  # 특정 브랜치나 태그로부터 최근 1개의 커밋 히스토리만 클론
    PREFIX ${CMAKE_BINARY_DIR}/install  # 외부 프로젝트를 다운 받아서 빌드하는 경로
    # 외부 프로젝트의 CMake Configure 인수로 전달
    CMAKE_ARGS -D CMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/install  # 외부 프로젝트를 설치할 파일 경로
)

# 의존성 리스트 및 라이브러리 파일 리스트 추가
list(APPEND DEPS dep-spdlog)
list(APPEND LIBS spdlog$<$<CONFIG:Debug>:d>)