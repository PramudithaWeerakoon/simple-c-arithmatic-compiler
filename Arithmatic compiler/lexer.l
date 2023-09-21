%{
#include "calculator.tab.h"
%}

%%
[0-9]+(\.[0-9]+)? {
    yylval = atof(yytext);
    return NUMBER;
}
[ \t] ;
\n {
    return yytext[0];
}
. {
    return yytext[0];
}
%%

int yywrap(void) {
    return 1;
}

