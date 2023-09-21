%{
#include <stdio.h>
#include <math.h>

int yylex(void);
void yyerror(const char* msg);

double result = 0.0;

%}

%token NUMBER

%%

input: /* empty */
    | input line '\n' {
        printf("Result: %.2lf\n", result); // Limit to two decimal points
        result = 0.0;
    }
    ;

line: expr { result = $1; }
    ;

expr:   NUMBER          { $$ = $1; }
    | expr '+' expr    { $$ = $1 + $3; }
    | expr '-' expr    { $$ = $1 - $3; }
    | expr '*' expr    { $$ = $1 * $3; }
    | expr '/' expr    { 
        if ($3 == 0) {
            yyerror("Division by zero");
            $$ = 0;
        } else {
            $$ = $1 / $3;
        }
    }
    | error { yyerror("Syntax error"); $$ = 0; }
    ;

%%

void yyerror(const char* msg) {
    fprintf(stderr, "Error: %s\n", msg);
}

int main() {
    printf("Simple Calculator\n");
    printf("Enter expressions, one per line. Press Ctrl+D to exit.\n");
    yyparse();
    return 0;
}

