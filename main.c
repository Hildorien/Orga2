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
    ct_add(pct,20);
    ct_add(pct,50);
    ct_add(pct,100);
   	ctNode* nodo1 = malloc(sizeof(ctNode));
   // ct_add(pct,15);


    
    return 0;    
}



