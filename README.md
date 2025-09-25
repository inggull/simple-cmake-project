# A Simple CMake Project

CMake를 공부하며 작성한 간단한 CMake 프로젝트입니다.

## 명령어

`<CMAKE_SOURCE_DIR>`: `CMakeLists.txt` 파일이 있는 프로젝트의 최상위 경로  
`<CMAKE_BINARY_DIR>`: 프로젝트가 빌드되는 경로로, 관습적으로 `build`를 사용

### [Configure & Generate]

`cmake <CMAKE_SOURCE_DIR>` // 현재 폴더에 CMake 구성 파일들을 생성  
`cmake <CMAKE_SOURCE_DIR> -B <CMAKE_BINARY_DIR>` // `<CMAKE_BINARY_DIR>`에 CMake 구성 파일들을 생성

* CMake 변수를 생성하거나 변경하는 옵션: `-D <CMAKE_VARIABLE>=<VALUE>`
* `CMAKE_BUILD_TYPE`을 설정하는 옵션: `-D CMAKE_BUILD_TYPE=<BUILD_TYPE>` // 생성 단계의 `--config` 옵션보다 우선 순위로 적용
* 빌드 시스템의 생성 방식을 설정하는 옵션: `-G "<GENERATOR_NAME>"` // Unix Makefiles

### [Build]

`cmake --build <CMAKE_BINARY_DIR>` // 다중 구성을 지원하는 경우, 빌드 타입을 설정하는 옵션: `--config <BUILD_TYPE>`
