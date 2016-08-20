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
; void ct_delete(ctTree** pct);
ct_delete:
                                              ;rdi <-- pct (dir de memoria que apunta a un puntero al arbol)
      push rbp
      mov rbp,rsp                              ;dejo la pila alineada porque voy a llamar a otra funcion (free)

      

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



