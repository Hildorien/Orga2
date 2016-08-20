#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include "cuatrotree.h"

char *archivoCasoChico  =  "salida.caso.chico.txt";
char *archivoCasoGrande =  "salida.caso.grande.txt";
void casoC();
void casoG();

int main() {
  remove(archivoCasoChico);
  casoC();
  remove(archivoCasoGrande);
  casoG();
  return 0;
}

void printIterador(FILE *pFile, ctTree* myCT) {
    ctIter* ctIt = ctIter_new(myCT);
    ctIter_first(ctIt);
    for(int i=0;i<1000000000 && ctIter_valid(ctIt);i++) {
      fprintf(pFile,"%i - %i\n",ctIter_get(ctIt),ctIt->count);
      ctIter_next(ctIt);
    }
    ctIter_delete(ctIt);
}

void printAdd(FILE *pFile, ctTree* myCT, uint32_t i) {
    ct_add(myCT, i);
    fprintf(pFile,"%i - %i\n", i, myCT->size);
}

void casoC(){
    int i;
    FILE *pFile;
    pFile = fopen( archivoCasoChico, "a" );
    ctTree* myCT;
    fputs( ">>> Test : operaciones caso borde 1\n", pFile );
    ct_new(&myCT);
    printAdd(pFile, myCT, 100);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : operaciones caso borde 2\n", pFile );
    ct_new(&myCT);
    printAdd(pFile, myCT, 100);
    printAdd(pFile, myCT, 100);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : operaciones caso borde 3\n", pFile );
    ct_new(&myCT);
    printAdd(pFile, myCT, 100);
    printAdd(pFile, myCT, 200);
    printAdd(pFile, myCT, 300);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : operaciones caso borde 4\n", pFile );
    ct_new(&myCT);
    printAdd(pFile, myCT, 200);
    printAdd(pFile, myCT, 100);
    printAdd(pFile, myCT, 300);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : operaciones caso borde 5\n", pFile );
    ct_new(&myCT);
    printAdd(pFile, myCT, 300);
    printAdd(pFile, myCT, 200);
    printAdd(pFile, myCT, 100);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : operaciones caso borde 6\n", pFile );
    ct_new(&myCT);
    printAdd(pFile, myCT, 300);
    printAdd(pFile, myCT, 200);
    printAdd(pFile, myCT, 100);
    printAdd(pFile, myCT, 50);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : operaciones caso borde 7\n", pFile );
    ct_new(&myCT);
    printAdd(pFile, myCT, 300);
    printAdd(pFile, myCT, 200);
    printAdd(pFile, myCT, 100);
    printAdd(pFile, myCT, 500);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : operaciones caso borde 8\n", pFile );
    ct_new(&myCT);
    printAdd(pFile, myCT, 300);
    printAdd(pFile, myCT, 200);
    printAdd(pFile, myCT, 100);
    printAdd(pFile, myCT, 150);
    printAdd(pFile, myCT, 250);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : operaciones caso borde 9\n", pFile );
    ct_new(&myCT);
    printAdd(pFile, myCT, 300);
    printAdd(pFile, myCT, 200);
    printAdd(pFile, myCT, 100);
    printAdd(pFile, myCT, 150);
    printAdd(pFile, myCT, 50);
    printAdd(pFile, myCT, 250);
    printAdd(pFile, myCT, 500);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : operaciones caso borde 10\n", pFile );
    ct_new(&myCT);
    printAdd(pFile, myCT, 300);
    printAdd(pFile, myCT, 200);
    printAdd(pFile, myCT, 100);
    printAdd(pFile, myCT, 30);
    printAdd(pFile, myCT, 20);
    printAdd(pFile, myCT, 10);
    printAdd(pFile, myCT, 130);
    printAdd(pFile, myCT, 120);
    printAdd(pFile, myCT, 110);
    printAdd(pFile, myCT, 230);
    printAdd(pFile, myCT, 220);
    printAdd(pFile, myCT, 210);
    printAdd(pFile, myCT, 530);
    printAdd(pFile, myCT, 520);
    printAdd(pFile, myCT, 510);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : caso chico random 1\n", pFile );
    srand(70);
    ct_new(&myCT);
    for(i=0;i<100;i++)
      printAdd(pFile, myCT, rand()%100);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : caso chico random 2\n", pFile );
    srand(970);
    ct_new(&myCT);
    for(i=0;i<100;i++)
      printAdd(pFile, myCT, rand()%100);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : caso chico random 3\n", pFile );
    srand(870);
    ct_new(&myCT);
    for(i=0;i<100;i++)
      printAdd(pFile, myCT, rand()%1000);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : caso chico random 4\n", pFile );
    srand(770);
    ct_new(&myCT);
    for(i=0;i<100;i++)
      printAdd(pFile, myCT, rand()%1000);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : caso chico random 5\n", pFile );
    srand(670);
    ct_new(&myCT);
    for(i=0;i<100;i++)
      printAdd(pFile, myCT, rand()%1000);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : caso chico random 6\n", pFile );
    srand(570);
    ct_new(&myCT);
    for(i=0;i<100;i++)
      printAdd(pFile, myCT, rand()%100000000);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : caso chico random 7\n", pFile );
    srand(470);
    ct_new(&myCT);
    for(i=0;i<100;i++)
      printAdd(pFile, myCT, rand()%100000000);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : caso chico random 8\n", pFile );
    srand(370);
    ct_new(&myCT);
    for(i=0;i<100;i++)
      printAdd(pFile, myCT, rand()%100000000);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : caso chico random 9\n", pFile );
    srand(270);
    ct_new(&myCT);
    for(i=0;i<100;i++)
      printAdd(pFile, myCT, rand()%100000000);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : caso chico random 10\n", pFile );
    srand(170);
    ct_new(&myCT);
    for(i=0;i<100;i++)
      printAdd(pFile, myCT, rand()%100000000);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fclose( pFile );
}

void casoG() {
    int i;
    FILE *pFile;
    pFile = fopen( archivoCasoGrande, "a" );
    ctTree* myCT;
    fputs( ">>> Test : caso grande random 1\n", pFile );
    srand(700);
    ct_new(&myCT);
    for(i=0;i<10000;i++)
      printAdd(pFile, myCT, rand()%100000);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : caso grande random 2\n", pFile );
    srand(9700);
    ct_new(&myCT);
    for(i=0;i<10000;i++)
      printAdd(pFile, myCT, rand()%100000);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : caso grande random 3\n", pFile );
    srand(8700);
    ct_new(&myCT);
    for(i=0;i<10000;i++)
      printAdd(pFile, myCT, rand()%100000);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : caso grande random 4\n", pFile );
    srand(7700);
    ct_new(&myCT);
    for(i=0;i<10000;i++)
      printAdd(pFile, myCT, rand()%100000000);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fputs( ">>> Test : caso grande random 5\n", pFile );
    srand(6700);
    ct_new(&myCT);
    for(i=0;i<100000;i++)
      printAdd(pFile, myCT, rand()%100000000);
    ct_print(myCT,pFile);
    printIterador(pFile,myCT);
    ct_delete(&myCT);
    fclose( pFile );
}
