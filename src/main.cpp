#include <spdlog/spdlog.h>
extern "C" {
#include <add.h>
}

int main() {
    spdlog::info("1 + 1 = {}", add(1, 1));
    return 0;
}