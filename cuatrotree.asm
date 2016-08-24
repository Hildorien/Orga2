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
      
      mov rbx,rdi 
      cmp rbx,NULL                            ;me fijo si me pasaron la dir NULL que es cuando ya no hay mas nodo
      je .fin                                 ;en ese caso voy al fin
      
      mov  rdi,[rbx+NODE_OFFSET_CHILD]       ;copio a rdi el puntero a hijo[0]
      call ct_aux_destructorrecursivo        ;vuelvo a llamar la funcion pero con el hijo[0] como nodo de parametro
     
      mov  rdi,[rbx+NODE_OFFSET_CHILD1]       ;copio a rdi el puntero a hijo[1]
      call ct_aux_destructorrecursivo
    
      mov  rdi,[rbx+NODE_OFFSET_CHILD2]       ;copio a rdi el puntero a hijo[2]
      call ct_aux_destructorrecursivo
      
      mov  rdi,[rbx+NODE_OFFSET_CHILD3]       ;copio a rdi el puntero a hijo[3]
      call ct_aux_destructorrecursivo
                                         
      mov rdi,rbx                        ;copio la dir de rbx(que es la del nodo) a rdi
      call free                          ;elimino la hoja
    
      .fin:
      add rsp,8
      pop rbx
      pop rbp
      ret                                ;en las llamadas recursivas el ret vuelve a ubicarse una linea despues de la llamada que hizo y asi se fija con todos los hijos del nodo
; void ct_delete(ctTree** pct);
ct_delete:
                                              ;rdi <-- pct (dir de memoria que apunta a un puntero al arbol)
      push rbp
      mov rbp,rsp                              ;dejo la pila alineada porque voy a llamar a otra funcion (free)
      push rbx
      sub rsp,8
      
      mov rbx,[rdi]                            ;guardo en rbx la direccion del arbol con [rdi] y ademas para no perderla ya que hago free despues
      mov rdi,rbx                              ;copio en rdi la direccion del arbol(antes tenia **)
      cmp qword [rdi+TREE_OFFSET_ROOT],NULL    ;comparo con la dir en [rbx] (donde esta el arbol) para ver si esta vacio
      je .end                              
                                            
      mov rdi,[rdi+TREE_OFFSET_ROOT]           ;guardo en rdi el puntero a la raiz que es un puntero a nodo para llamar a la funcion aux
      call ct_aux_destructorrecursivo
 
      .end:                                    ;en este caso el arbol esta vacio , entonces elimino la estructura
      mov rdi,rbx               
      call free
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

      mov [rax+ITER_OFFSET_TREE],rbx        ;muevo la direccion del arbol guardada previamente en rbx
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
;rdi <--- puntero al iterador
ctIter_first:
        mov rsi,[rdi+ITER_OFFSET_TREE]        ;copio a rsi la direccion del arbol 
        cmp qword [rsi+TREE_OFFSET_ROOT],NULL ;me fijo si el arbol es vacio
        je .vacio            

        cmp dword [rsi+TREE_OFFSET_CANT],1       ;si el arbol tiene un solo nodo (es hoja)
        jne .haymashijos
        mov rsi,[rsi+TREE_OFFSET_ROOT]   ;muevo a rsi la direccion del nodo que apunta a la raiz
        mov [rdi+ITER_OFFSET_NODE],rsi   ;actualizo el puntero a nodo del iterador con el nodo q apunta a la raiz
        jmp .fin
        
        .haymashijos:
        mov rsi,[rsi+TREE_OFFSET_ROOT]            ;copio a rsi la direccion de la raiz
        .ciclo:
        cmp qword [rsi+NODE_OFFSET_CHILD],NULL    ;comparo la dir del child[0] con NULL para ver si existe
        je .fin
        mov rsi,[rsi+NODE_OFFSET_CHILD]       ;mientras exista child[0] apuntar al child[0]
        mov [rdi+ITER_OFFSET_NODE],rsi        ;escribo en rdi en la direccion del nodo, es decir la direccion de child[0] guardado en rsi
        jmp .ciclo
        
        .vacio:
        mov qword [rdi+ITER_OFFSET_NODE],NULL ;el nodo al que apunta get es NULL

        .fin:
        mov dword [rdi+ITER_OFFSET_COUNT],0
        ret

; =====================================
; unint 32_t ctIter_aux_isIn(ctNode* current, ctNode* father)
ctIter_aux_isIn:
            
            cmp [rsi+NODE_OFFSET_CHILD],rdi  ;si la direccion del hijo[0] del padre coincide con el nodo actual , entonces subir por el hijo[0] en padre
            je .Esdelhijo0

            cmp [rsi+NODE_OFFSET_CHILD1],rdi
            je .Esdelhijo1

            cmp [rsi+NODE_OFFSET_CHILD2],rdi
            je .Esdelhijo2

            cmp [rsi+NODE_OFFSET_CHILD3],rdi
            je .Esdelhijo3

            .Esdelhijo0:
            mov rax,0
            ret

            .Esdelhijo1:
            mov rax,1
            ret

            .Esdelhijo2:
            mov rax,2
            ret

            .Esdelhijo3:
            mov rax,3
            ret

;void call ctIter_aux_up(ctIter* ctIt)
ctIter_aux_up:
          push rbp
          mov rbp,rsp
          push rbx
          push r12
          push r13
          sub rsp,8
          
          mov rbx,rdi                       ;guardo la dir de rdi en rbx para no perderla
          mov r12,[rbx+ITER_OFFSET_NODE]    ;copio a rbx la direccion del nodo al que apunta el iterador
          mov r13,[r12+NODE_OFFSET_FATHER]  ;copio a r12 la direccion del padre del nodo al que apunta el iterador
          mov rdi,r12                       ;copio rdi la dir el nodo al que apunta el iterador
          mov rsi,r13                       ;copio a rsi la dir del padre del nodo al que apunta el iterador
          call ctIter_aux_isIn   

          cmp rax,0
          je .Voyacurrent0 ;si rax devolvio 0 es porque el nodo actual es el hijo0 del padre entonces el siguiente elemento del iterador debe apuntar al value[0] del padre
          cmp rax,1
          je .Voyacurrent1
          cmp rax,2
          je .Voyacurrent2
          cmp rax,3       ;si rax devolvio 3 es porque el nodo actual es el hijo3 del padre y ya recorrio todos los nodos
          je .fin

          .Voyacurrent0:
          mov rdi,rbx
          mov [rdi+ITER_OFFSET_NODE],r13
          mov byte [rdi+ITER_OFFSET_CURRENT],0
          jmp .fin

          .Voyacurrent1:
          mov rdi,rbx
          mov [rdi+ITER_OFFSET_NODE],r13
          mov byte [rdi+ITER_OFFSET_CURRENT],1
          jmp .fin

          .Voyacurrent2:
          mov rdi,rbx
          mov [rdi+ITER_OFFSET_NODE],r13
          mov byte [rdi+ITER_OFFSET_CURRENT],2
          jmp .fin

          .fin:
          add rsp,8
          pop r13
          pop r12
          pop rbx
          pop rbp
          ret
;ctIter_aux_down(crIter* ctIt)
ctIter_aux_down:
          push rbp
          mov rbp,rsp
          push rbx
          sub rsp,8

          mov rbx,[rdi+ITER_OFFSET_NODE] ;copio a rbx la dir del nodo al que apunta el iterador
            .ciclo:
            cmp qword [rbx+NODE_OFFSET_CHILD],NULL  ;mientras la dir del hijo[0] no sea cero bajar
            je .fin
            mov rbx,[rbx+NODE_OFFSET_CHILD]         ;mientras haya hijo[0] , actualizar el puntero a nodo del iterador
            mov [rdi+ITER_OFFSET_NODE],rbx
            jmp .ciclo

          .fin:
          add rsp,8
          pop rbx
          pop rbp
          ret

; void ctIter_next(ctIter* ctIt);
;rdi<-- puntero al iterador
ctIter_next:
        push rbp
        mov rbp,rsp
        push rbx
        push r12
        push r13
        push r14
        sub rsp,8

        xor rbx,rbx
        xor r12,r12
        xor r14,r14
        
        mov rbx,rdi                                   ;guardo la dir del iterador para no perderlo
        mov r12,[rbx+ITER_OFFSET_CURRENT]             ;guardo en r12 el valor de current
        mov r13,[rbx+ITER_OFFSET_NODE]                ;guardo en r13 la dir del nodo al que apunta
        inc r12                                       ;incremento 1 el current
        add dword [rbx+ITER_OFFSET_COUNT],1           ;incremento 1 el contador porque el iterador se movio
        cmp qword [r13+NODE_OFFSET_CHILD+r12],NULL    ;if(ctIt->node->child[ctIt->current] == 0)
        jne .haymashijos
        mov r14,[r13+NODE_OFFSET_LEN]
        dec r14
        
        cmp r12,r14            ;if(ctIt->current > ctIt->node->len -1)
        jle .fin
        mov rdi,rbx
        call ctIter_aux_up
        jmp .fin

        .haymashijos:
        lea r13,[r13+NODE_OFFSET_CHILD+r12]      ; ctIt->node = ctIt->node->child[ctIt->current]
        mov rdi,rbx                               ;muevo a rdi la direccion del puntero al iterador pasado como parametro
        mov [rdi+ITER_OFFSET_NODE],r13            ;actualizo el puntero a nodo del iterador
        call ctIter_aux_down

        .fin:
        add rsp,8
        pop r14
        pop r13
        pop r12
        pop rbx
        pop rbp
        ret

; =====================================
;uint32_t ctIter_get(ctIter* ctIt);
;rdi <-- puntero al iterador
ctIter_get:
    
    mov rsi,[rdi+ITER_OFFSET_TREE]         ;copio a rsi la dir del arbol
    cmp qword [rsi+TREE_OFFSET_ROOT],NULL ;me fijo que el arbol esta vacio
    je .arbolvacio
    mov rcx,[rdi+ITER_OFFSET_NODE] 
    mov eax,[rcx+NODE_OFFSET_VALUE]
    jmp .fin
    
    .arbolvacio:
    mov eax,0   ;si el arbol es vacio get devuelve 0

    .fin:
    ret

; =====================================
; uint32_t ctIter_valid(ctIter* ctIt);
ctIter_valid:
      cmp qword [rdi+ITER_OFFSET_NODE],NULL ;me fijo si el puntero a nodo es null
      je .invalido
      mov rax,1                       ;si es valido devuelve 1

      .invalido:
      mov rax,0                       ; si es invalido devuelve 0


      ret



