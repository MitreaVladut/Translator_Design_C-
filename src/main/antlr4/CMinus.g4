
grammar CMinus;

program
    : declaration+ EOF
    ;

declaration
    : varDeclaration
    | funDeclaration
    ;

varDeclaration
    : typeSpecifier ID (LBRACK NUM RBRACK)? SEMI
    ;

typeSpecifier
    : INT
    | VOID
    ;

funDeclaration
    : typeSpecifier ID LPAREN params RPAREN compoundStmt
    ;

params
    : paramList
    | VOID
    ;

paramList
    : param (COMMA param)*
    ;

param
    : typeSpecifier ID (LBRACK RBRACK)?
    ;

compoundStmt
    : LBRACE localDeclarations statement* RBRACE
    ;

localDeclarations
    : varDeclaration*
    ;

statement
    : expressionStmt
    | compoundStmt
    | selectionStmt
    | iterationStmt
    | returnStmt
    ;

expressionStmt
    : expression? SEMI
    ;

selectionStmt
    : IF LPAREN expression RPAREN statement
      (ELSE statement)?
    ;

iterationStmt
    : WHILE LPAREN expression RPAREN statement
    ;

returnStmt
    : RETURN expression? SEMI
    ;

expression
    : var ASSIGN expression
    | simpleExpression
    ;

var
    : ID (LBRACK expression RBRACK)?
    ;

simpleExpression
    : additiveExpression (relop additiveExpression)?
    ;

relop
    : LE | LT | GT | GE | EQ | NE
    ;

additiveExpression
    : term (addop term)*
    ;

addop
    : PLUS | MINUS
    ;

term
    : factor (mulop factor)*
    ;

mulop
    : STAR | SLASH
    ;

factor
    : LPAREN expression RPAREN
    | call
    | var
    | NUM
    ;

call
    : ID LPAREN args RPAREN
    ;

args
    : (expression (COMMA expression)*)?
    ;

ELSE   : 'else';
IF     : 'if';
INT    : 'int';
RETURN : 'return';
VOID   : 'void';
WHILE  : 'while';

LE     : '<=';
LT     : '<';
GE     : '>=';
GT     : '>';
EQ     : '==';
NE     : '!=';
ASSIGN : '=';
PLUS   : '+';
MINUS  : '-';
STAR   : '*';
SLASH  : '/';

SEMI   : ';';
COMMA  : ',';
LPAREN : '(';
RPAREN : ')';
LBRACK : '[';
RBRACK : ']';
LBRACE : '{';
RBRACE : '}';

NUM : [0-9]+;
ID  : [a-zA-Z] [a-zA-Z0-9_]*;

COMMENT : '/*' .*? '*/' -> skip;
WS      : [ \t\r\n]+ -> skip;
