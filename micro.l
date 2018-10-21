%{
#include <stdlib.h>
#include <stdio.h>
%}
%option noyywrap

espacio         [ \t]+
digito          [0-9]
integer         {digito}+

%%

{espacio}           { /* Ignoramos espacios en blanco */ }
"exit"|"quit"|"bye"	{printf("Terminando programa\n");exit(0);}
{integer}	        {
                        yylval.dval=atoi(yytext);
                        return(NUMERO);
                    }

"+"           return(SIMB_MAS);
"-"           return(SIMB_MENOS);
"*"           return(MULTI);
"/"           return(DIVIDIR);
"^"           return(POTENCIA);
"("           return(PARENT_IZQUIERDO);
")"           return(PARENT_DERECHO);
"\n"  return(FIN);

%%
