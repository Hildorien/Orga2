#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "cuatrotree.h"

int main (void){
    char* name = "imprimearbol.txt";
    FILE *pFile = fopen( name, "w" );
    
    fprintf(pFile,"-\n");
   
    ctTree* pct;
    ct_new(&pct);
   //ctIter* it = ctIter_new(pct);
    ct_add(pct,10);
    ct_add(pct,50);
    ct_add(pct,30); 
    ct_add(pct,5);
    ct_add(pct,20); 
    ct_add(pct,40);
    ct_add(pct,60);
    ct_add(pct,19);
    ct_add(pct,39);
    ct_add(pct,4);
    ct_print(pct,pFile);



     /* ctIter_first(it);
      int r = ctIter_get(it);
      printf("%d\n",r );

      ctIter_next(it);
      int j = ctIter_get(it);
      printf("%d\n",j );

      ctIter_next(it);
      int k = ctIter_get(it);
      printf("%d\n",k );

      ctIter_next(it);
      int l = ctIter_get(it);
      printf("%d\n",l );

       ctIter_next(it);
      int m = ctIter_get(it);
      printf("%d\n",m );

       ctIter_next(it);
      int n = ctIter_get(it);
      printf("%d\n",n );

       ctIter_next(it);
      int o = ctIter_get(it);
      printf("%d\n",o );

      ctIter_next(it);
      int p = ctIter_get(it);
      printf("%d\n",p );

      ctIter_next(it);
      int q = ctIter_get(it);
      printf("%d\n",q );

      ctIter_next(it);
      int a = ctIter_get(it);
      printf("%d\n",a );*/



   // ctIter_delete(it);
    ct_delete(&pct);
   
   
   



    fclose( pFile ); 
    
    return 0;    
}



