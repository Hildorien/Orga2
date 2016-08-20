; FUNCIONES de C
  extern malloc
  extern free
  extern fprintf
   
; FUNCIONES
  global ct_new
  global ct_delete
  global ct_print
  global ctIter_new
  global ctIter_delete
  global ctIter_first
  global ctIter_next
  global ctIter_get
  global ctIter_valid
 
; define OFFSETS y SIZES
%define TREE_OFFSET_ROOT 0
%define TREE_OFFSET_CANT 8 ;cant es size que son cant de nodos y es un uint32_t -> ocupa 4 bytes
%define TREE_OFFSET_SIZE 12
%define NODE_OFFSET_FATHER 0
%define NODE_OFFSET_VALUE 8
%define NODE_OFFSET_LEN 20 ;len es uint8_t -> ocupa 1 byte
%define NODE_OFFSET_CHILD 21
%define NODE_OFFSET_CHILD1 29
%define NODE_OFFSET_CHILD2 37
%define NODE_OFFSET_CHILD3 45
%define NODE_OFFSET_SIZE 53 
%define NULL 0
%define ITER_OFFSET_TREE 0
%define ITER_OFFSET_NODE 8
%define ITER_OFFSET_CURRENT 16 ;current es un uint8_t -> ocupa 1 byte
%define ITER_OFFSET_COUNT 17
%define ITER_OFFSET_SIZE 21 


section .text

; =====================================
; void ct_new(ctTree** pct);
ct_new:
                                              ;rdi <--- *pct (en rdi hay una direccion de memoria que apunta a otra dir. de memoria)
      push rbp                                ;pila alineada (como voy a pedir memoria llamando a malloc necesito que la pila este alineada)
      mov rbp,rsp
      push rbx                                ;pila desalineada
      sub rsp,8                               ;pila alineada
     
      mov rbx,rdi                             ;rdx = rdi es decir rdx guarda la direccion de memoria de pct*
      mov rdi,TREE_OFFSET_SIZE                ;muevo a rdi lo que ocupa un arbol para llamar a malloc
      call malloc                             ;en rax me devolvio la direccion de memoria donde me almaceno 12B (lo que ocupa un arbol)

      mov qword [rax+TREE_OFFSET_ROOT],NULL   ;cuando se crea el arbol la raiz apunta a NULL
      mov dword [rax+TREE_OFFSET_CANT],0      ;el arbol vacio tiene 0 nodos
      mov [rbx],rax                           ;actualizo la direccion de pct reapuntdolo al arbol vacio que acabo de crear 
                                              ;con malloc moviendo al rdi original lo que devolvio rax
                                              
      add rsp,8
      pop rbx
      pop rbp                                 ;desapilo para volver a la dir de retorno
      ret

; =====================================
;void ct_aux_destructorrecursivo(ctNode* n)
ct_aux_destructorrecursivo:
      push rbp
      mov rbp,rsp
      push rbx
      sub rsp,8

      mov rbx,rdi      ;muevo a r13 la direccion del nodo
      cmp  qword [rbx+NODE_OFFSET_CHILD],NULL ;me fijo si no tiene child[0]
      je .siguechild1
      jmp .tienehijo0
      .siguechild1:
      cmp qword [rbx+NODE_OFFSET_CHILD1],NULL ;me fijo si no tiene child[1] sabiendo que no hay en los  anteriores
      je .siguechild2                  ; si no tiene hijo me fijo el siguiente
      jmp .tienehijo1                  ; si tiene hijo salto a hacer la parte recursiva con ese nodo
      .siguechild2:
      cmp qword [rbx+NODE_OFFSET_CHILD2],NULL ;me fijo si no tiene child[2] sabiendo que no hay en los anteriores
      je .siguechild3
      jmp .tienehijo2
      .siguechild3:
      cmp qword [rbx+NODE_OFFSET_CHILD3],NULL ;me fio si no tiene child[3] sabiendo que no hay en los anteriores
      je .eliminarhoja
      jmp .tienehijo3

      .eliminarhoja:
      mov rdi,rbx                    ;copio la dir de r13(que es la del nodo) a rdi
      call free                       
      jmp .fin

      .tienehijo0:
      mov  qword rdi,[rbx+NODE_OFFSET_CHILD] ;copio a rdi el puntero a hijo[0]
      call ct_aux_destructorrecursivo        ;vuelvo a llamar la funcion pero con el hijo[0] como nodo de parametro

      .tienehijo1:
      mov  qword rdi,[rbx+NODE_OFFSET_CHILD1] ;copio a rdi el puntero a hijo[1]
      call ct_aux_destructorrecursivo

      .tienehijo2:
      mov  qword rdi,[rbx+NODE_OFFSET_CHILD2] ;copio a rdi el puntero a hijo[2]
      call ct_aux_destructorrecursivo

      .tienehijo3:
      mov  qword rdi,[rbx+NODE_OFFSET_CHILD3] ;copio a rdi el puntero a hijo[3]
      call ct_aux_destructorrecursivo



      .fin:
      add rsp,8
      push rbx
      pop rbp
      ret
; void ct_delete(ctTree** pct);
ct_delete:
                                              ;rdi <-- pct (dir de memoria que apunta a un puntero al arbol)
      push rbp
      mov rbp,rsp                              ;dejo la pila alineada porque voy a llamar a otra funcion (free)
      push rbx
      sub rsp,8
      
      mov rbx,rdi                            ;guardo en rbx la direccion de pct para no perderla
      cmp qword [rbx],NULL                         ;comparo con la dir en [rbx] (donde esta el arbol) para ver si esta vacio
      jne .else                              ;si no esta vacio voy a else
                                            ;si esta vacio prosigo
      mov rax,[rbx]                         ;ubico la dir del arbol en rax
      mov rdi,rax                           ;copio la dir del arbol a rdi para usar free
      call free                             ;libera la memoria alocada por el arbol vacio

      .else:                                ;el arbol no es vacio
        mov qword rdi,[rbx+TREE_OFFSET_ROOT]    ;muevo a rdi la dir de la raiz del arbol
        call ct_aux_destructorrecursivo

      add rsp,8
      pop rbx
      pop rbp
      ret

; ; =====================================
; ; void ct_aux_print(ctNode* node);
ct_aux_print:
        ret

; ; =====================================
; ; void ct_print(ctTree* ct);
ct_print:
        ret

; =====================================
; ctIter* ctIter_new(ctTree* ct);
ctIter_new:
      push rbp
      mov rbp,rsp
      push rbx
      sub rsp,8

      mov rbx,rdi
      mov rdi,ITER_OFFSET_SIZE
      call malloc

      mov qword [rax+ITER_OFFSET_TREE],rbx  ;muevo la direccion del arbol guardada previamente en rbx
      mov qword [rax+ITER_OFFSET_NODE],NULL ;el iterador es invalido asique apunta a un nodo NULL
      mov byte [rax+ITER_OFFSET_CURRENT],0  ;el iterador tiene el indice 0 porque no apunta a nada
      mov dword [rax+ITER_OFFSET_COUNT],0   ;el iterador es invalido entonces no recorrio nada

      mov rbx,rax                           ;actualizo la direccion de ct guardada previamente en rbx que ahora guarda la nueva direccion donde llame a malloc

      add rsp,8
      pop rbx
      pop rbp                               ;desapilo para volver a la dir de retorno
      ret

; =====================================
; void ctIter_delete(ctIter* ctIt);
ctIter_delete:
        jmp free
        ret

; =====================================
; void ctIter_first(ctIter* ctIt);
ctIter_first:
        ret

; =====================================
; void ctIter_next(ctIter* ctIt);
ctIter_next:
        ret

; =====================================
; uint32_t ctIter_get(ctIter* ctIt);
ctIter_get:
        ret

; =====================================
; uint32_t ctIter_valid(ctIter* ctIt);
ctIter_valid:
        ret



