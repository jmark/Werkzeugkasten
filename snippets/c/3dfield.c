# include <stdlib.h>
# include <stdio.h>

# define Nx 4
# define Ny 4 
# define Nz 3

typedef int index;
typedef int T;

typedef struct space3 space3;
struct space3 {
    index N[3];
    T* space;
};

index I2(space3* A,index i,index j) {
    return i*A->N[1]+j;
}

index I3(space3* A,index i,index j,index k) {
    return I2(A,i,j)*A->N[2]+k;
}

void loop2(space3* A,void (*f)(space3*,index i,index j,void* args),void* args) {
    for (index i = 0; i < A->N[0]; ++i) {
        for (index j = 0; j < A->N[1]; ++j) {
            f(A,i,j,args);
        }
    }
}

void loop3(space3* A,void (*f)(space3*,index i,index j,index k,void* args),void* args) {
    for (index i = 0; i < A->N[0]; ++i) {
        for (index j = 0; j < A->N[1]; ++j) {
            for (index k = 0; k < A->N[2]; ++k) {
                f(A,i,j,k,args);
            }
        }
    }
}

void f(space3* A,index i,index j,index k,void* args) {
    static int c = 0;
    int* offset = (int*)args;
    A->space[I3(A,i,j,k)] = *offset + c++;
}

void out(space3* A,index i,index j,void* args) {
    printf("%d %d =>\t%d\t%d\t%d\n",i,j,
        A->space[I3(A,i,j,0)],
        A->space[I3(A,i,j,1)],
        A->space[I3(A,i,j,2)]);
}

int main(int argc,char** argv) {

    space3 A;
    A.N[0] = 10;
    A.N[1] = 10;
    A.N[2] = 3;
    A.space = malloc(A.N[0]*A.N[1]*A.N[2]*sizeof(T));

    int arg = 0;
    loop3(&A,f,&arg);
    loop2(&A,out,0);

    return 0;
}
