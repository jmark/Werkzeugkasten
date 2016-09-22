#include <stdio.h>
#include <stdlib.h>

# define LISTLEN 10

float list2[] = { 0.0f,1.0f,2.0f,3.0f };
//int list2[] = { 0,1,2,3 };

int main (void)
{
    float *list = (float*) malloc ( sizeof(float)*LISTLEN );

	int i = 0;
	for ( i = 0 ; i < LISTLEN ; i++ )
	{
		list[i] = i;
	}

	for ( i = 0 ; i < LISTLEN ; i++ )
	{
		printf ("i -> %f\n", list[i] );
	}


	printf ( "\n\n" );


	float *list3 = (float*) malloc ( sizeof(list2) );	

	printf ("int:    %d\n", (int)sizeof(int));
	printf ("long:   %d\n", (int)sizeof(long));
	printf ("float:  %d\n", (int)sizeof(float));
	printf ("double: %d\n", (int)sizeof(double));
	printf ("list2   %d\n", (int)sizeof(list2));
	printf ("list3   %d\n", (int)sizeof(list3));

	printf ( "\n\n" );

	for ( i = 0 ; i < (int)sizeof(list2)/(int)sizeof(float) ; i++ )
	{
		list3[i] = list2[i];
	}

	for ( i = 0 ; i < (int)sizeof(list2)/(int)sizeof(float); i++ )
	{
		printf ( "%d -> %f\n", i, list3[i] );
	}


	return 0;
}
