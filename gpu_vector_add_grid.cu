#include <iostream>

const int N = 65537;

__global__ void add(int *a, int *b, int *c)
{
    int tid = threadIdx.x + blockIdx.x * blockDim.x;
    while (tid < N)
    {
        c[tid] = a[tid] + b[tid];
        tid += blockDim.x * gridDim.x;
    }
}

int main(void)
{
   int a[N], b[N], c[N];
   int *dev_a, *dev_b, *dev_c;
   for (int i = 0; i < N; ++i)
   {
       a[i] = i;
       b[i] = i;
   }
   cudaMalloc((void**)&dev_a, N*sizeof(int));
   cudaMalloc((void**)&dev_b, N*sizeof(int));
   cudaMalloc((void**)&dev_c, N*sizeof(int));
   
   cudaMemcpy(dev_a, a, N * sizeof(int), cudaMemcpyHostToDevice);
   cudaMemcpy(dev_b, b, N * sizeof(int), cudaMemcpyHostToDevice);

   add<<<128, 128>>>(dev_a, dev_b, dev_c);

   cudaMemcpy(c, dev_c, N * sizeof(int), cudaMemcpyDeviceToHost);

   for (int i=0; i < N; ++i)
   {
       std::cout << a[i] << "+" << b[i] << "=" << c[i] << std::endl;

   }
   return 0;
}
