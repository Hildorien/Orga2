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
    ctIter* it = ctIter_new(pct);
      ct_add(pct,20);
      ct_add(pct,30);
      ct_add(pct,100); 
      //  ct_add(pct,10);
     // ct_add(pct,40); 
      //ct_add(pct,25);
  



      ctIter_first(it);
     // int r = ctIter_get(it);
     // printf("%d\n",r );

      ctIter_next(it);
      int j = ctIter_get(it);
      printf("%d\n",j );

      ctIter_next(it);
      int k = ctIter_get(it);
      printf("%d\n",j );

      ctIter_next(it);
      int l = ctIter_get(it);
      printf("%d\n",j );


    ctIter_delete(it);
    ct_delete(&pct);
   
   
   




    
    return 0;    
}



