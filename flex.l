/*** Definition Section has one variable
which can be accessed inside yylex() 
and main() ***/


%{
struct token {
   char  id[50];
   char  lexem[50];
};  

typedef struct token Token;
int len =  0;

struct token token_arr[100];

void insert(char id[], char lexem[]){
    Token value;
    strcpy(value.id, id);
    strcpy(value.lexem, lexem);
    token_arr[len] = value;
    len++;
}


%}

number [0-9]
letter [a-zA-Z]
variable {letter}([_]|{letter}|{number})*
comments "{"[^}\n]*"}"
whitespace [ \t\n]+
assignment [=]
not_valid_assignment {assignment}{2,}
operators ["*"]
not_valid_operators ["+"|"-"|"/"]
linebreaker [^\n]
  

/*
a = some value integer
a*a 
*/

%%

"EOF" {return 0;}

{variable}  {
    printf("%s is a valid token\n", yytext);
    insert("variable", yytext);
}

{number}+    {
    printf("%s is a number\n", yytext);
    insert("number", yytext);
}

{operators} {
    printf("%s is a valid operator\n", yytext);
    insert("operator", yytext);
}

{not_valid_operators} {
    printf("%s is not a valid operator, did you mean \"*\" ?\n", yytext);
}

{assignment} {
    printf("%s is a valid assignment\n", yytext);
    insert("assignment", yytext);
}

{not_valid_assignment} {
    printf("%s is a not valid assignment, did you mean \"=\" ?\n", yytext);
}

{comments}  /* eat up one-line comments */

{whitespace}    /* eat up whitespace */

.   {
    printf("%s is not a recognizable character or expression\n", yytext);
}

%%
  
/*** Code Section prints the number of
capital letter present in the given input***/
int yywrap(){}
int main(){
  
// Explanation:
// yywrap() - wraps the above rule section 
/* yylex() - this is the main flex function
          which runs the Rule Section*/
// yytext is the text in the buffer
  
yylex();

printf("------------------------------------------- \n");
printf("TOKEN -> LEXEM \n");

int i = 0;

for(i=0; i<len; i++){
    printf("%s -> %s \n", token_arr[i].id, token_arr[i].lexem);
}

printf("-------------------------------------------\n");
  
return 0;
}
