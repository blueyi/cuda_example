#include <iostream>

int main(void)
{
    int count;
    int dev;
    std::cout << cudaGetDeviceCount(&count) << std::endl;
    std::cout << count << std::endl;
    std::cout << cudaGetDevice(&dev) << std::endl;
    std::cout << dev << std::endl;
    return 0;
}
