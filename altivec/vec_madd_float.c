#include <stdio.h>
#include <altivec.h>

float a[4] __attribute__((aligned(16))) = {1.0, 3.2, 5.0, 7.2};
float b[4] __attribute__((aligned(16))) = {-2.1, 4.3, 6.4, 8.2};
float c[4] __attribute__((aligned(16))) = {1.0, 2.0, 3.0, 4.0};
float d[4] __attribute__((aligned(16)));

int main(int argc, char *argv)
{
	__vector float *va = (__vector float *) a;
	__vector float *vb = (__vector float *) b;
	__vector float *vc = (__vector float *) c;
	__vector float *vd = (__vector float *) d;
	*vd = vec_madd(*va, *vb, *vc);
        printf("d[0]=%f, d[1]=%f, d[2]=%f, d[3]=%f\n", d[0], d[1], d[2], d[3]);
	return 0; 

}
