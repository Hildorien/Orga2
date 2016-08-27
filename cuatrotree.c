#include "cuatrotree.h"

void ct_aux_SearchAndFill(ctTree* ct,ctNode* n,uint32_t newVal){ //Esta funcion busca e inserta recursivamente teniendo en cuenta los casos posibles del add en un cuatrotree
	if(n->len != 3) {
		if (n->len == 1){              //Si en el nodo  hay un solo valor
						
			if (newVal > n->value[0]){
				n->value[1] = newVal;
				n->len++;          		 //Como agrego un nuevo valor a value aumento len
				ct->size++;
			}
			if(newVal < n->value[0]){ 			 //En este caso el value[0] se corre al value[1] ya que newVal es mas chico
				n->value[1] = n->value[0];
				n->value[0] = newVal;
				n->len++;
				ct->size++;
			}
		}
		if (n->len == 2){ // Si en el nodo hay 2 valores
		
			if(newVal > n->value[0] && newVal < n->value[1]){ //En este caso newVal esta en el medio asique se corre val[1] a val[2] y se inserta newVal en el medio
				n->value[2] = n->value[1];
				n->value[1] = newVal;
				n->len++;
				ct->size++;

			}
			if(newVal > n->value[1]){ //En este caso newVal es mas grande q val[1] asique se inserta a su derecha
				n->value[2] = newVal;
				n->len++;
				ct->size++;
			}
			if(newVal < n->value[0]){ //En este caso newVal es mas chico que el primero(por ende el segundo tambien) entonces se corren a la derecha y se inserta newVal como primero
				n->value[2] = n->value[1];
				n->value[1] = n->value[0];
				n->value[0] = newVal;
				n->len++;
				ct->size++;
			}
		}
	}else{   //En este caso el nodo tiene los values llenos , por lo que hay que insertar en el hijo correcto
		if(newVal < n->value[0]){                     // Si es mas chico que el value[0]
				if(n->child[0] == NULL){                  // Si el nodo no tenia hijo de mas a la izquierda
					ctNode* nodo1 = malloc(sizeof(ctNode));
					nodo1->father = n;                  
					nodo1->value[0] = newVal;
					nodo1->len=1;               
					int i = 0;
					while (i < 4){
						nodo1->child[i] = NULL;           
						i++;
					}
					n->child[0] = nodo1;
					ct->size = ct->size + 1;
				}else{
					ct_aux_SearchAndFill(ct,n->child[0],newVal); //Si el nodo tenia hijo en child[0] vuelvo a aplicar la funcion recursivamente desde child[0]
				}
			}
		if(n->value[0] < newVal && newVal < n->value[1]){
				if (n->child[1] == NULL){					// Si no habia hijos en child[1]
					ctNode* nodo2;  						 
					nodo2 = malloc(sizeof(ctNode));
					nodo2->father = n;                  
					nodo2->value[0] = newVal;
					nodo2->len=1;               
					int i = 0;
					while (i < 4){
						nodo2->child[i] = NULL;        
						i++;
					}
					n->child[1] = nodo2;
					ct->size = ct->size + 1;
				}else{
					ct_aux_SearchAndFill(ct,n->child[1],newVal); //Si el nodo  tenia hijo en child[1] vuelvo a aplicar la funcion recursivamente desde child[1]
				}
		}
		if (n->value[1] < newVal && newVal < n->value[2]){
				if(n->child[2] == NULL){					//Si no habia hijos en child[2]
					ctNode* nodo3;  						 
					nodo3 = malloc(sizeof(ctNode));
					nodo3->father = n;                  
					nodo3->value[0] = newVal;
					nodo3->len=1;               
					int i = 0;
					while (i < 4){
						nodo3->child[i] = NULL;        
						i++;
					}
					n->child[2] = nodo3;
					ct->size = ct->size + 1;
				}else{
					ct_aux_SearchAndFill(ct,n->child[2],newVal); //Si el nodo tenia hijo en child[2] vuelvo a aplicar la funcion recursivamente desde child[2]
				}

		}
		if(newVal > n->value[2]){
				if(n->child[3] == NULL){
					ctNode* nodo4;  						 
					nodo4 = malloc(sizeof(ctNode));
					nodo4->father = n;                  
					nodo4->value[0] = newVal;
					nodo4->len=1;               
					int i = 0;
					while (i < 4){
						nodo4->child[i] = NULL;        
						i++;
					}
					n->child[3] = nodo4;
					ct->size = ct->size + 1;
				}else{
					ct_aux_SearchAndFill(ct,n->child[3],newVal);  //Si el nodo tenia hijo en child[3] vuelvo a aplicar la funcion recursivamente desde child[3]
				}
			}


	}
}

void ct_add(ctTree* ct, uint32_t newVal){
	if(ct->root == NULL){                       // si el arbol estaba vacio
		ctNode* nodo = malloc(sizeof(ctNode));	// creo un nuevo nodo para que sea la raiz
		nodo->father = NULL;                  // como va a ser la raiz no tiene padre
		nodo->value[0] = newVal;              // como el nodo tiene un solo valor el value[0] guarda el valor a insertar , el resto no hay nada
		nodo->len = 1;
		int i = 0;
		while (i < 4){
			nodo->child[i] = NULL;           //el nodo no tiene hijos , luego sus hijos son todos NULL
			i++;
		}
		ct->root = nodo;                // la raiz apunta al nodo que cree
		ct->size = 1;
	}else{
		ct_aux_SearchAndFill(ct,ct->root,newVal);  //Si el arbol no es vacio llamo a una funcion que ubica el valor y lo inserta en el lugar correcto
	}
}	
	
	