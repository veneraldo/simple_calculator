#include <stdio.h>
#include <altivec.h>

int a[4] __attribute__((aligned(16))) = {1, 3, 5, 7};
int b[4] __attribute__((aligned(16))) = {2, 4, 6, 8};
int c[4] __attribute__((aligned(16)));
float vd;
int main(int argc, char *argv)
{
	__vector signed int *va = (__vector signed int *) a;
	__vector signed int *vb = (__vector signed int *) b;
	__vector signed int *vc = (__vector signed int *) c;
	vd = vec_madd(*va, *vb, *vc);
        printf("vd=%d\n", vd);
	return 0; 

}
