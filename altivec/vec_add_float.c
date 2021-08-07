#include <stdio.h>
#include <altivec.h>

float a[8] __attribute__((aligned(16))) = {1.0, 3.2, 5.0, 7.2,1,2,3,5};
float b[8] __attribute__((aligned(16))) = {2.1, 4.3, 6.4, 8.2, 1,2,3,5};
float c[8] __attribute__((aligned(16)));

int main(int argc, char *argv)
{
	__vector float *va = (__vector float *) a;
	__vector float *vb = (__vector float *) b;
	__vector float *vc = (__vector float *) c;
	int i;
	for {i=0; i<8l i++)
	*vc[i] = vec_add(*va[i], *vb[i]);
        printf("c[0]=%f, c[1]=%f, c[2]=%f, c[7]=%f\n", c[0], c[1], c[2], c[7]);
	return 0; 

}
