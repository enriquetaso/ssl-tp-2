%{
#include <math.h>
%}

%token  <dval> NUMERO 
%token  SIMB_MAS    SIMB_MENOS   MULTI	DIVIDIR  POTENCIA
%token  PARENT_IZQUIERDO	PARENT_DERECHO
%token  FIN

%left   SIMB_MAS    SIMB_MENOS
%left   MULTI  DIVIDIR
%left   NEGADO
%right  POTENCIA

%type <dval> Expresion
%start Input

%%

Input:	Linea
	| Input Linea
    ;

Linea:	FIN
        | Expresion FIN                { printf("Resultado: %f\n",$1); }
        ;

Expresion:	NUMERO                        { $$=$1; }
        | Expresion SIMB_MAS Expresion    { $$=$1+$3; }
        | Expresion SIMB_MENOS Expresion   { $$=$1-$3; }
        | Expresion MULTI Expresion   { $$=$1*$3; }
        | Expresion DIVIDIR Expresion  { $$=$1/$3; }
        | SIMB_MENOS Expresion %prec NEGADO    { $$=-$2; }
        | Expresion POTENCIA Expresion   { $$=pow($1,$3); }
        | PARENT_IZQUIERDO Expresion PARENT_DERECHO { $$=$2; }
        ;

%%
int yyerror(char *s) {
  printf("Error: no se reconoce la operación.\n");
}

int main(void) {
  yyparse();
}