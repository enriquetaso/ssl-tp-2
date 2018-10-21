%{
#include <stdio.h>
#include "y.tab.h"
%}

%option noyywrap
separador       ([ \t””])+
digito          [0-9]
letra           [a-zA-Z]
identificador   {letra}({letra}|{digito})*
constEntera     {digito}({digito})* 

%%

{separador}     { /* Ignoramos los separadores */ }
{constEntera}   {return(CONSTENTERA);}
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
{identificador} {return(IDENTIFICADOR);}
\n              {return(NL);}
.               ECHO; 
<<EOF>>     	{return(FDT);}
%%
