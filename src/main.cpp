#include <spdlog/spdlog.h>
extern "C" {
#include <add.h>
}

int main() {
    SPDLOG_INFO("1 + 1 = {}", add(1, 1));
    return 0;
}