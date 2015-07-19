#include <iostream>


__global__ void add(int a, int *b, int *c) //声明需要在GPU中执行的核函数
{
	*c = a + *b;
}

int main(void)
{
	int b, c;
	b = 3;
	int *dev_b, *dev_c; //声明GPU需要使用到的指针
	cudaMalloc((void **)&dev_b, sizeof(int)); //在GPU内存中为dev_b分配内存
	cudaMalloc((void **)&dev_c, sizeof(int)); //在GPU内存中为dev_c分配内存
	cudaMemcpy(dev_b, &b, sizeof(int), cudaMemcpyHostToDevice); //将核函数需要的数据复制到设备内存
	add<<<1,1>>>(2, dev_b, dev_c); //调用核函数
	cudaMemcpy(&c, dev_c, sizeof(int), cudaMemcpyDeviceToHost); //将计算结果dev_c中的数据从设备内存复制到主机内存
	std::cout << 2 << " + " << b << " = " << c << std::endl;
	cudaFree(dev_b); //释放设备内存
	cudaFree(dev_c);
	return 0;
}
