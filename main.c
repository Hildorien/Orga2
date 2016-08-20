#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "cuatrotree.h"

int main (void){
 /*   char* name = "cambiameporotronombre.txt";
    FILE *pFile = fopen( name, "a" );
    
    fprintf(pFile,"-\n");
        
    fclose( pFile ); */
    ctTree* pct;
    ct_new(&pct);
    ct_add(pct,10);
    ct_add(pct,20);
    ct_add(pct,30);   	

    ct_delete(&pct);


    
    return 0;    
}



