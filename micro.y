%{
#include <stdio.h>
%}

%union {
	int int_val
}

%token  <int_val> NUMERO   CONSTENTERA
%token  SIMB_MAS    SIMB_MENOS   NL  FDT
%token  PARENT_IZQUIERDO	PARENT_DERECHO   IDENTIFICADOR
%token  INICIO  FIN  LEER  ESCRIBIR  ASIGNACION  COMA PUNTOYCOMA

%left   SIMB_MAS    SIMB_MENOS   ASIGNACION

%start Objetivo

%%


Objetivo : Programa FDT
			;
			
Programa : INICIO ListaSentencias  FIN 
			;
			
ListaSentencias : Sentencia	
				| ListaSentencias NL Sentencia
				;
				
Sentencia : IDENTIFICADOR ASIGNACION Expresion PUNTOYCOMA
			| LEER PARENT_IZQUIERDO ListaIdentificadores PARENT_DERECHO PUNTOYCOMA
			| ESCRIBIR PARENT_IZQUIERDO ListaExpresiones PARENT_DERECHO PUNTOYCOMA
			;

ListaIdentificadores : IDENTIFICADOR
					| IDENTIFICADOR COMA ListaIdentificadores
					;
			
ListaExpresiones : Expresion
				| Expresion COMA ListaExpresiones
				;
			
Expresion :	Primaria 
			| Primaria OperadorAditivo Expresion
			;

Primaria : IDENTIFICADOR 
		| CONSTENTERA 
		| PARENT_IZQUIERDO Expresion PARENT_DERECHO ;

OperadorAditivo : SIMB_MAS 
				| SIMB_MENOS 
				;

%%
int yyerror(char *s) {
  printf("Error: no se reconoce la operacion.\n");
}

int main(void) {
  yyparse();
}