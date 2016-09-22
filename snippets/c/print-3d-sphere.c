# include <stdlib.h>
# include <stdio.h>
# include <math.h>

int main ( void )
{
    # define PI 3.14159

    double radius = 1.0;
    double phi    = 0.0;
    double theta  = 0.0;

    double stepW = 0.1;

    double minPhi = 0.0;
    double maxPhi = 2*PI;

    double minTheta = 0.0;
    double maxTheta = PI;

    unsigned int len = (maxPhi-minPhi)/stepW * (maxTheta-minTheta)/stepW * 3;

    //double *result = (double*) malloc (sizeof(double)*len);

    //if (result == 0) exit (1);

    long long int i = 0;
    for ( phi = minPhi ; phi <= maxPhi ; phi += stepW )
    {
        for ( theta = minTheta ; theta <= maxTheta ; theta += stepW )
        {
            double x = radius * cos ( phi ) * sin ( theta );
            double y = radius * sin ( phi ) * sin ( theta );
            double z = radius * cos ( theta );
            
            //result[i]   = x*x;
            //result[i+1] = y*z;
            //result[i+2] = z*y;
       
            x = x*x;
            y = y*z;
            z = z*y;

            //printf ( "%d\n", i );

            //printf ( "%d -> %f\t%f\t%f\n", i, x,y,z );
            printf ( "%f\t%f\t%f\n", x,y,z );
            i += 3;
        }
    }
   
    //for ( i = 0 ; i < len ; i += 3 )
    //{
    //    printf ( "%f\t%f\t%f\n", result[i], result[i+1], result[i+2] );
    //}

    return 0;
}
