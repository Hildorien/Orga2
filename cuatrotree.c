#include "cuatrotree.h"

void ct_addRecursivo(ctTree* ct,ctNode* n,uint32_t newVal){ //Esta funcion me permite insertar el nuevo valor de manera recursiva 
	ct->root = n;                                           // en el caso dnd la raiz ya tiene un hijo , entonces hay que bajar un nivel
	ct_add(ct,newVal);                                      // y lo que hago en esta funcion es llamar a add pero con la raiz cambiada al nodo de un "nivel abajo"
}


void ct_addConValueLLeno(ctTree* ct, uint32_t newVal){
		if(newVal < ct->root->value[0]){                     // Si es mas chico que el value[0]
				if(ct->root->child[0] == NULL){                  // Si la raiz no tenia hijo de mas a la izquierda
					ctNode* nodo1 = malloc(sizeof(ctNode));
					nodo1->father = ct->root;                  
					nodo1->value[0] = newVal;
					nodo1->len++;               
					int i = 0;
					while (i <= 4){
						nodo1->child[i] = NULL;           
						i++;
					}
					ct->root->child[0] = nodo1;
				}else{
					ct_addRecursivo(ct,ct->root->child[0],newVal); //Si la raiz tenia hijo en child[0] vuelvo a aplicar la funcion recursivamente desde child[0]
				}
			}
			if(ct->root->value[0] < newVal && newVal < ct->root->value[1]){
				if (ct->root->child[1] == NULL){					// Si no habia hijos en child[1]
					ctNode* nodo2;  						 
					nodo2 = malloc(sizeof(ctNode));
					nodo2->father = ct->root;                  
					nodo2->value[0] = newVal;
					nodo2->len++;               
					int i = 0;
					while (i <= 4){
						nodo2->child[i] = NULL;        
						i++;
					}
					ct->root->child[1] = nodo2;
				}else{
					ct_addRecursivo(ct,ct->root->child[1],newVal); //Si la raiz tenia hijo en child[1] vuelvo a aplicar la funcion recursivamente desde child[1]
				}
			}
			if (ct->root->value[1] < newVal && newVal < ct->root->value[2]){
				if(ct->root->child[2] == NULL){					//Si no habia hijos en child[2]
					ctNode* nodo3;  						 
					nodo3 = malloc(sizeof(ctNode));
					nodo3->father = ct->root;                  
					nodo3->value[0] = newVal;
					nodo3->len++;               
					int i = 0;
					while (i <= 4){
						nodo3->child[i] = NULL;        
						i++;
					}
					ct->root->child[2] = nodo3;
				}else{
					ct_addRecursivo(ct,ct->root->child[2],newVal); //Si la raiz tenia hijo en child[2] vuelvo a aplicar la funcion recursivamente desde child[2]
				}
			}
			if(newVal > ct->root->value[2]){
				if(ct->root->child[3] == NULL){
					ctNode* nodo4;  						 
					nodo4 = malloc(sizeof(ctNode));
					nodo4->father = ct->root;                  
					nodo4->value[0] = newVal;
					nodo4->len++;               
					int i = 0;
					while (i <= 4){
						nodo4->child[i] = NULL;        
						i++;
					}
					ct->root->child[3] = nodo4;
				}else{
					ct_addRecursivo(ct,ct->root->child[3],newVal); //Si la raiz tenia hijo en child[3] vuelvo a aplicar la funcion recursivamente desde child[3]
				}
			}
}	


void ct_add(ctTree* ct, uint32_t newVal){
	ct->size = ct->size + 1;
	if (ct->root == NULL){                //si el arbol esta vacio
		ctNode* nodo = malloc(sizeof(ctNode));					 // creo un nuevo nodo para que sea la raiz
		nodo->father = NULL;                  // como va a ser la raiz no tiene padre
		nodo->value[0] = newVal;              // como el nodo tiene un solo valor el value[0] guarda el valor a insertar , el resto no hay nada
		nodo->len++;
		int i = 0;
		while (i <= 4){
			nodo->child[i] = NULL;           //el nodo no tiene hijos , luego sus hijos son todos NULL
			i++;
		}
		ct->root = nodo;                // la raiz apunta al nodo que cree
	}
	else{
	if (ct->root->len == 1){              //Si en la raiz hay un solo valor
						
			if (newVal > ct->root->value[0]){
				ct->root->value[1] = newVal;
				ct->root->len++;          		 //Como agrego un nuevo valor a value aumento len
			}
			if(newVal < ct->root->value[0]){  //En este caso el value[0] se corre al value[1] ya que newVal es mas chico
				ct->root->value[1] = ct->root->value[0];
				ct->root->value[0] = newVal;
				ct->root->len++;
			}
		}
		if (ct->root->len == 2){ // Si en la raiz hay 2 valores
			//ct->root->len++;	 //Como agrego un nuevo valor a value aumento len
			if(newVal > ct->root->value[0] && newVal < ct->root->value[1]){ //En este caso newVal esta en el medio asique se corre val[1] a val[2] y se inserta newVal en el medio
				ct->root->value[2] = ct->root->value[1];
				ct->root->value[1] = newVal;
				ct->root->len++;

			}
			if(newVal > ct->root->value[1]){ //En este caso newVal es mas grande q val[1] asique se inserta a su derecha
				ct->root->value[2] = newVal;
				ct->root->len++;
			}
			if(newVal < ct->root->value[0]){ //En este caso newVal es mas chico que el primero(por ende el segundo tambien) entonces se corren a la derecha y se inserta newVal como primero
				ct->root->value[2] = ct->root->value[1];
				ct->root->value[1] = ct->root->value[0];
				ct->root->value[0] = newVal;
				ct->root->len++;
			}
		}
	//A partir de ahora los values de la raiz estan llenos
		if(ct->root->len ==3){
			ct_addConValueLLeno(ct,newVal);
		}	
	}
}		

	
	
	