#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include "kernel.h"
#include <stdio.h>
//поздравл€ю заработало, pochti gotovo

#define SIZE 1024

__global__ void addKernel(int *c, int *a, int *b)
{
	int i = threadIdx.x;
	c[i] = a[i] * b[i];
}

int main()
{

	int *dev_a, *host_a, *dev_b, *host_b, *host_c, *dev_c;
	host_a = (int *)malloc(SIZE * sizeof(int));
	host_b = (int *)malloc(SIZE * sizeof(int));
	host_c = (int *)malloc(sizeof(int) * SIZE);
	host_c[0] = 0;
	for (int i = 0; i < SIZE; i++)
	{
		host_a[i] = i;
		host_b[i] = i;
		host_c[i] = 0;
	}
	StartTimer();
	cudaMalloc((void**)&dev_a, sizeof(int) * SIZE);
	cudaMalloc((void**)&dev_b, sizeof(int) * SIZE);
	cudaMalloc((void**)&dev_c, sizeof(int) * SIZE);

	cudaMemcpy(dev_a, host_a, sizeof(int) * SIZE, cudaMemcpyHostToDevice);
	cudaMemcpy(dev_b, host_b, sizeof(int) * SIZE, cudaMemcpyHostToDevice);
	cudaMemcpy(dev_c, host_c, sizeof(int) * SIZE, cudaMemcpyHostToDevice);

	addKernel<<<1, SIZE >>>(dev_c, dev_a, dev_b);

	cudaDeviceSynchronize();

	cudaMemcpy(host_a, dev_a, SIZE * sizeof(int), cudaMemcpyDeviceToHost);
	cudaMemcpy(host_b, dev_b, SIZE * sizeof(int), cudaMemcpyDeviceToHost);
	cudaMemcpy(host_c, dev_c, SIZE * sizeof(int), cudaMemcpyDeviceToHost);
	cudaFree(dev_a);
	cudaFree(dev_c);
	cudaFree(dev_b);
	for (int i = 1; i < SIZE; i++ )
		host_c[0] += host_c[i];
	printf("%d", host_c[0]);
	double runtime = GetTimer();

	printf(" total: %f s\n", runtime / 1000);
	getchar();
	return 0;
}