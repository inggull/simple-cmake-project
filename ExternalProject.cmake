# ExternalProject는 빌드 시에 외부 프로젝트를 클론해와서
# 자체적으로 구성, 빌드, 설치하는 과정으로 프로젝트와 통합한다
# ExternalProject 관련 명령어 셋을 추가한다
include(ExternalProject)

# 클론해올 외부 프로젝트 이름과 여러 옵션들을 설정한다
ExternalProject_Add(
    spdlog # 외부 프로젝트 이름
    GIT_REPOSITORY https://github.com/gabime/spdlog.git # 원격 저장소 주소
    GIT_TAG v1.x # 특정 브랜치나 태그
    GIT_SHALLOW 1 # 특정 브랜치나 태그로부터 최근 1개의 커밋 히스토리만 클론한다
    PREFIX ${CMAKE_BINARY_DIR}/install # 외부 프로젝트를 클론해서 빌드하는 경로
    CMAKE_ARGS # 외부 프로젝트의 CMake 구성시 인수로 전달한다
        -D CMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/install # 외부 프로젝트를 설치할 파일 경로
)

# 의존성 리스트 및 라이브러리 파일 리스트를 추가한다
list(APPEND DEPS spdlog)
list(APPEND LIBS spdlog$<$<CONFIG:Debug>:d>) # Build 단계의 CONFIG 인수가 Debug일경우 d를 추가한다