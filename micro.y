%{
#include <stdio.h>
%}

%union {
	int dval
}

%token  <dval> CONSTENTERA
%token  SIMB_MAS    SIMB_MENOS   NL  FDT
%token  PARENT_IZQUIERDO	PARENT_DERECHO   IDENTIFICADOR
%token  INICIO  FIN  LEER  ESCRIBIR  ASIGNACION  COMA PUNTOYCOMA

%left   SIMB_MAS    SIMB_MENOS
%right  ASIGNACION

%start Objetivo

%%


Objetivo : Programa FDT {printf("<programa> FDT\n");};
			
Programa : INICIO FIN 							{printf("INICIO FIN\n");}
		|  INICIO ListaSentencias FIN 			{printf("INICIO <listaSentencias> FIN\n");}
		;
			
ListaSentencias : Sentencia						{printf("<sentencia> \n");}
				| ListaSentencias Sentencia		{printf("<sentencia> {<sentencia>} \n");}
				;
				
Sentencia : IDENTIFICADOR ASIGNACION Expresion PUNTOYCOMA 							{printf("ID ASIGNACION <expresion> ;\n");}
			| LEER PARENT_IZQUIERDO ListaIdentificadores PARENT_DERECHO PUNTOYCOMA	{printf("LEER ( <listaIdentificadores> ) ; \n");}
			| ESCRIBIR PARENT_IZQUIERDO ListaExpresiones PARENT_DERECHO PUNTOYCOMA	{printf("ESCRIBIR ( <listaExpresiones> ) ;\n");}
			;

ListaIdentificadores : IDENTIFICADOR							{printf("ID\n");}
					| IDENTIFICADOR COMA ListaIdentificadores	{printf("ID { COMA ID }\n");}
					;
			
ListaExpresiones : Expresion						{printf("<expresion>\n");}
				| Expresion COMA ListaExpresiones	{printf("<expresion> {COMA <expresion>}\n");}
				;			
Expresion :	Primaria								{printf("<primaria>\n");}
			| Primaria OperadorAditivo Expresion	{printf("<primaria> {<operadorAditivo> <primaria>}\n");}
			;
			
Primaria : IDENTIFICADOR 							{printf("ID\n");}
		| CONSTENTERA 								{printf("CONSTANTE: %d\n", $1);}
		| PARENT_IZQUIERDO Expresion PARENT_DERECHO {printf("( <expresion> )\n");}
		;

OperadorAditivo : SIMB_MAS		{printf("SUMA\n");}
				| SIMB_MENOS	{printf("RESTA\n");} 
				;

%%
FILE *yyin;

int yyerror(char *s) {
  printf("Error: no se reconoce la operacion %s.\n", s);
}

int main(int argc, char *argv[]) {
	int i = 0;
	if(argc < 2) {
		printf("Ingrese su codigo de forma manual\n");
		yyparse();
	} else {
		printf("Se va a leer el codigo del archivo: %s\n", argv[1]);
		if(yyin=fopen(argv[1],"rb")){
			yyparse();
		} else {
			printf("Error al abrir el archivo\n", argv[1]);
		}
	}
	system("pause");
}

