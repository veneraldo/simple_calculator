#include <stdio.h>
#include <altivec.h>

int main()
{
	int N=4;
	vector float A[N], C[N];
        vector float B[4] = vector float(1.1, 2.2, 3.3, 4.5);
	int i;
	for ( i=0; i<N; i++ )
	//vector float f32 = vector float(1.1, 2.2, 3.3, 4.39501);
        A[i] = vec_add( B[i], C[i]);
	printf("A[1] = %f\n", A[1] );

	return 0; 

}
