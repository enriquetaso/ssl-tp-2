%{
#include <stdio.h>
#include "y.tab.h"
%}

%option noyywrap
separador       [ \t]+
digito          [0-9]
letra           [a-zA-Z]
identificador   {letra}({letra}|{digito})*
entero			{digito}+

%%

{separador}     { /* Ignoramos los separadores */ }
"exit"|"salir"	{printf("Terminando programa\n");exit(0);}
{entero}	    {
					yylval.dval=atoi(yytext);
                    return(CONSTENTERA);
                }
"inicio"        {return(INICIO);}
"fin"           {return(FIN);}
"leer"          {return(LEER);}
"escribir"      {return(ESCRIBIR);}
":="            {return(ASIGNACION);}
","             {return(COMA);}
";"             {return(PUNTOYCOMA);}
"+"             {return(SIMB_MAS);}
"-"             {return(SIMB_MENOS);}
"("             {return(PARENT_IZQUIERDO);}
")"             {return(PARENT_DERECHO);}
{identificador} {
					if(strlen(yytext) > 32) {
						printf("Error en la dimension del nombre del Identificador\n");					
					} else {
						return IDENTIFICADOR;
					}
				}
"."				{return(FDT);}
%%
