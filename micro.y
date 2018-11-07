%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


void asignarIdentificador(char * identificador, int value);
void obtenerValor(char * identificador);
int  devolverValor(char * identificador);
%}

%union {
	int dval;
	char* caracteres;
}

%token  <dval> CONSTENTERA
%token  SIMB_MAS    SIMB_MENOS   NL  FDT
%token  PARENT_IZQUIERDO	PARENT_DERECHO   IDENTIFICADOR
%token  INICIO  FIN  LEER  ESCRIBIR  ASIGNACION  COMA PUNTOYCOMA

%left   SIMB_MAS    SIMB_MENOS	COMA
%right  ASIGNACION	

%type <dval> Expresion Primaria
%type <caracteres> IDENTIFICADOR Sentencia

%start Objetivo

%%

Objetivo : Programa FDT {exit(0);};
			
Programa : INICIO FIN 							{}
		|  INICIO ListaSentencias FIN 			{}
		;
			
ListaSentencias : ListaSentencias Sentencia		{}
				| Sentencia						{}
				;
				
Sentencia : IDENTIFICADOR ASIGNACION Expresion PUNTOYCOMA 		{printf("\nIdentificada operacion de asignacion\n%s:=%d;",$1,$3);asignarIdentificador($1, $3); }
			| LEER PARENT_IZQUIERDO ListaIdentificadores PARENT_DERECHO PUNTOYCOMA	{printf("\nIdentificada operacion de lectura\n");}
			| ESCRIBIR PARENT_IZQUIERDO ListaExpresiones PARENT_DERECHO PUNTOYCOMA	{printf("\nIdentificada operacion de escritura\n");}
			;

ListaIdentificadores : ListaIdentificadores COMA IDENTIFICADOR 	{obtenerValor($3);}
					|  IDENTIFICADOR							{obtenerValor($1);}
					;
			
ListaExpresiones : ListaExpresiones COMA Expresion 	{printf(", %d", $3);}
				| Expresion							{printf("%d", $1);}
				
				;			
Expresion :	Primaria						{$$ = $1;}
			| Primaria SIMB_MAS Expresion	{$$ = $1 + $3;}
			| Primaria SIMB_MENOS Expresion	{$$ = $1 - $3;}
			;
			
Primaria : IDENTIFICADOR 							{$$ = devolverValor($1);}
		| CONSTENTERA 								{$$ = $1;}
		| PARENT_IZQUIERDO Expresion PARENT_DERECHO {$$ = $2;}
		;
%%
FILE *yyin;

typedef struct Identificador {
		char identificador[33];
		int valor;
} Identificador;

Identificador arrayIdentificadores[100];
int cantidadIdentificadores = 0;
int buscarIdentificador(char * identificador);
void insertarIdentificador(char * identificador, int value);
void asignarIdentificador(char * identificador, int value);
void obtenerValor(char * identificador);
int devolverValor(char * identificador);


int yyerror(char *s) {
	if(!strcmp(s, "syntax error")) printf("Error: Error de sintaxis.\n");
	else	printf("Error: %s.\n", s);
	exit(-1);
}

int buscarIdentificador(char * identificador) {
	int i;
	for(i = 0; i < cantidadIdentificadores; i++) {
		if(!strcmp(arrayIdentificadores[i].identificador,identificador)){
			return i;
		}
	}
	return -1;
}

int devolverValor(char * identificador) {
	int indice = buscarIdentificador(identificador);
	if(indice < 0) { yyerror("Identificador no inicializado"); }
	return arrayIdentificadores[indice].valor;
}

void insertarIdentificador(char * identificador, int value) {
	int indice = cantidadIdentificadores;
	strcpy(arrayIdentificadores[indice].identificador, identificador);
	arrayIdentificadores[indice].valor = value;
	cantidadIdentificadores++;
}

void asignarIdentificador(char * identificador, int value) {	
	int indiceIdentificador;
	indiceIdentificador = buscarIdentificador(identificador);
	if(indiceIdentificador < 0) {
		insertarIdentificador(identificador, value);
	} else {
		arrayIdentificadores[indiceIdentificador].valor = value;		
	}	
}

void obtenerValor(char * identificador) {
	int aux;
	printf("ingrese valor para %s: ", identificador);
	scanf("%d",&aux); 
	asignarIdentificador(identificador, aux);	
}

int main(int argc, char *argv[]) {
	if(argc < 2) {
		printf("Ingrese su codigo de forma manual\n");
		yyparse();
	} else {
		printf("Se va a leer el codigo del archivo: %s\n", argv[1]);
		if((yyin=fopen(argv[1],"rb"))){
			yyparse();
		} else {
			printf("Error al abrir el archivo %s\n", argv[1]);
		}
	}
}

