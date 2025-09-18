#include <iostream>
#include <spdlog/spdlog.h>
#include <add.h>

int main() {
    SPDLOG_INFO("1 + 1 = {}", add(1, 1));
    return 0;
}