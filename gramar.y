/* 
Practica Final Procesadores del lenguaje
100330670 David Morcuende Cantador
100329993 Pablo Ramos de la Cal
*/

%{                          // SECCION 1 Declaraciones de C-Yacc
#include <stdio.h>
#include <string.h>           // declaraciones para cadenas
#include <stdlib.h>           // declaraciones para exit ()
#define FF fflush(stdout);    // para forzar la impresion inmediata

typedef struct dim_var{
    char nombre[30];
    int dimension;
}tabla_dim;

typedef struct func{
    char funcion[31];
    int num_par;
    int contador_atributos;
    char par[20][21];
}datos_func;

char funcion [32] = "";
int pos_tabla_dim = 0;
int pos_tabla_func = 0;

int pos_contador_func=0;

tabla_dim tabla_dimension[100];
datos_func tabla_funciones[30];

char pila_func[20][31];

char * getDim(char * nom){
    int aux;
    for(aux=0;aux<pos_tabla_dim;aux++){
        if(strcmp(tabla_dimension[aux].nombre, nom)==0){
            char *valor=(char *)malloc(11) ;
            sprintf(valor,"%d * ",tabla_dimension[aux].dimension);
            return valor;		
        }
    }
    return "";
}

char * getIdentif (char * var){
    int aux;
    if(pos_tabla_func==0) return var;

    for(aux=0;aux<tabla_funciones[pos_tabla_func-1].num_par;aux++){
        if(strcmp(tabla_funciones[pos_tabla_func-1].par[aux], var)==0){
            char *valor=(char *)malloc(51);
            sprintf(valor,"%s_%s", tabla_funciones[pos_tabla_func-1].funcion, var);
            return valor;
        }
    }
    return var;
}

void nuevaVar(char * var){
    if(strcmp(funcion,"")!=0){
        strcpy(tabla_funciones[pos_tabla_func-1].par[tabla_funciones[pos_tabla_func-1].num_par],var);
        tabla_funciones[pos_tabla_func-1].num_par++;
    }
}

char * getAtrib(char * funcAux){
    int aux;
    for (aux=0;aux<pos_tabla_func;aux++){
        if(strcmp(tabla_funciones[aux].funcion,funcAux)==0){
            return tabla_funciones[aux].par[tabla_funciones[aux].contador_atributos++];
        }
    }
    return "ERROR";
}

void reiniciarAtrb(char * funcAux){
    int aux;
    for (aux=0;aux<pos_tabla_func;aux++){
        if(strcmp(tabla_funciones[aux].funcion,funcAux)==0){
            tabla_funciones[aux].contador_atributos=0;
        }
    }
}

%}

%union {                      // El tipo de la pila tiene caracter dual
    int valor ;               // - valor numerico de un NUMERO
    char *cadena ;            // - para pasar los nombres de IDENTIFES
}

%token <valor> NUMERO         // Todos los token tienen un tipo para la pila
%token <cadena> IDENTIF       // Identificador=variable
%token <cadena> INTEGER       // identifica la definicion de un entero
%token <cadena> STRING
%token <cadena> PUTS
%token <cadena> MAIN          // identifica el comienzo del proc. main
%token <cadena> DO            // identifica la palabra reservada DO
%token <cadena> WHILE         // identifica la palabra reservada WHILE
%token <cadena> EQUAL         // identifica los operadores logicos
%token <cadena> NOT
%token <cadena> MAYOREQUAL
%token <cadena> MENOREQUAL
%token <cadena> ANDAND
%token <cadena> OROR
%token <cadena> MENOSMENOS
%token <cadena> MASMAS
%token <cadena> IF
%token <cadena> ELSE
%token <cadena> PRINTF
%token <cadena> FOR
%token <cadena> RETURN
%right '='                    // es la ultima operacion que se debe realizar
%left OROR
%left ANDAND
%left '|'
%left '&'
%left NOT EQUAL
%left MAYOREQUAL MENOREQUAL '<' '>'
%left '+' '-'                 // menor orden de precedencia
%left '*' '/' '%'             // orden de precedencia intermedio
%left MASMAS MENOSMENOS '!'
%left SIGNO_UNARIO            // mayor orden de precedencia
%%
                                          // Seccion 3 Gramatica - Semantico
programa:			definicion principal 				{ ; }
			;


definicion:			/*lambda*/							{ ; }
			|	INTEGER IDENTIF '(' 					{strcpy(tabla_funciones[pos_tabla_func].funcion,$2);sprintf(funcion,"%s_",$2);}
														{pos_tabla_func++;}
					parametros ')'					
					'{' def_var 						{printf(": %s\n",$2);FF;}
					codigo '}' 							{strcpy(funcion,""); printf("\n;\n");FF;}
					definicion
			|	IDENTIF '(' 							{strcpy(tabla_funciones[pos_tabla_func].funcion,$1);sprintf(funcion,"%s_",$1);}
														{pos_tabla_func++;}
					parametros ')'					
					'{' def_var 						{printf(": %s\n",$1);FF;}
					codigo '}' 							{strcpy(funcion,""); printf("\n;\n");FF;}
					definicion
			|	INTEGER IDENTIF ';'						{printf("variable %s%s \n",funcion,$2);FF;}
														{nuevaVar($2);}
					definicion
			|	INTEGER IDENTIF '[' NUMERO ']' ';'		{printf("variable %s%s %d cells allot\n",funcion,$2,$4-1);FF;}
														{nuevaVar($2);}
					definicion	
			|	INTEGER IDENTIF '[' NUMERO ']' '[' NUMERO ']' ';'	
														{nuevaVar($2);}
														{sprintf(tabla_dimension[pos_tabla_dim].nombre,"%s",getIdentif($2));
															tabla_dimension[pos_tabla_dim].dimension = $7;
															pos_tabla_dim++;}	
														{printf("variable %s%s %d %d * cells allot\n",funcion,$2,$4,$7);FF;}
					definicion							
			;

parametros:			/* lambda */						{ ; }
			|	INTEGER IDENTIF 						{printf("variable %s%s \n",funcion,$2);FF;}
														{nuevaVar($2);}
				nuevo_parametro
			|	INTEGER IDENTIF '[' NUMERO ']' 
														{printf("variable %s%s %d cells allot\n",funcion,$2,$4-1);FF;}
														{nuevaVar($2);}
				nuevo_parametro
			|	INTEGER IDENTIF '[' NUMERO ']' '[' NUMERO ']'
														{nuevaVar($2);}
														{sprintf(tabla_dimension[pos_tabla_dim].nombre,"%s",getIdentif($2));
															tabla_dimension[pos_tabla_dim].dimension = $7;
															pos_tabla_dim++;}	
														{printf("variable %s%s %d %d * cells allot\n",funcion,$2,$4,$7);FF;}
				nuevo_parametro
			;
		
nuevo_parametro:		/*lambda*/						{ ; }
			| ',' parametros							{ ; }
			;
			
def_var:		 /*lambda*/ 							{ ; }
			|	INTEGER IDENTIF ';'						{printf("variable %s%s \n",funcion,$2);FF;}
														{nuevaVar($2);}
					def_var
			|	INTEGER IDENTIF '[' NUMERO ']' ';'	
														{printf("variable %s%s %d cells allot\n",funcion,$2,$4-1);FF;}
														{nuevaVar($2);}
					def_var
			|	INTEGER IDENTIF '[' NUMERO ']' '[' NUMERO ']' ';'	
														{nuevaVar($2);}
														{sprintf(tabla_dimension[pos_tabla_dim].nombre,"%s",getIdentif($2));
															tabla_dimension[pos_tabla_dim].dimension = $7;
															pos_tabla_dim++;}	
														{printf("variable %s%s %d %d * cells allot\n",funcion,$2,$4,$7);FF;}
					def_var
			;

principal:		MAIN 									{strcpy(tabla_funciones[pos_tabla_func].funcion,"main");sprintf(funcion,"%s_","main");}
														{pos_tabla_func++;}
					'(' ')' '{' def_var    				{printf(": main\n");FF;} 
					codigo '}'		     				{strcpy(funcion,""); printf("\n;\n");FF;}
														{printf("main\n");}
			;
			
codigo:			/* lambda */ 							{ ; }
			|	asignacion ';' 							{printf("\n");FF;}
					codigo
			|	PUTS '(' STRING ')' ';'					{printf(".\" %s \" ", $3);FF;}
					codigo
			|	DO 										{printf("begin \n");FF;}
					'{' codigo '}' WHILE 
					'(' expresion ')' ';'				{printf("while repeat \n");FF;} 
					codigo
			|	WHILE 									{printf("begin \n");FF;}
					'(' expresion ')' 					{printf("while \n");FF;} 
					'{' codigo '}' 						{printf("repeat\n");FF;} 
					codigo
			|	FOR '(' asignacion ';'					{printf("begin \n");FF;}
					expresion ';'						{printf("while \n");FF;} 
					fin_for 
			|	IF '(' expresion ')' 					{printf("if \n");FF;}
					'{' codigo '}'  finIf
			|	PRINTF '(' STRING ',' expresion fin_printf 
			|	incremento_decremento ';'				{printf("\n");FF;}
					codigo			
			|	IDENTIF 								{strcpy(pila_func[pos_contador_func],$1);pos_contador_func++;reiniciarAtrb($1);}
				'(' atributos  ')' ';'					{pos_contador_func--;}
														{printf("%s\n",$1);FF;} 
					codigo
			|	RETURN expresion ';'					{ ; }
					codigo
			;
						
atributos:		/*lambda*/
			| 	expresion 			{printf("%s_%s !\n",pila_func[pos_contador_func-1],getAtrib(pila_func[pos_contador_func-1]));FF;}
					nuevo_atributo
			;
			
nuevo_atributo: /*lambda*/
			| 	',' atributos
			;

fin_for:		MASMAS IDENTIF ')' '{' codigo '}'		{printf("%s @ 1 + %s !\nrepeat \n",getIdentif($2),getIdentif($2));FF;} 
					codigo
			|	MENOSMENOS IDENTIF ')' '{' codigo '}'	{printf("%s @ 1 - %s !\nrepeat \n",getIdentif($2),getIdentif($2));FF;} 
					codigo
			|	IDENTIF MASMAS ')' '{' codigo '}'		{printf("%s @ 1 + %s !\nrepeat \n",getIdentif($1),getIdentif($1));FF;} 
					codigo
			|	IDENTIF MENOSMENOS')' '{' codigo '}'	{printf("%s @ 1 - %s !\nrepeat \n",getIdentif($1),getIdentif($1));FF;} 
					codigo
			;

incremento_decremento:		MENOSMENOS IDENTIF	{printf ("%s @ 1 - %s ! ",getIdentif($2),getIdentif($2));FF;} 
			|	MASMAS IDENTIF					{printf ("%s @ 1 + %s ! ",getIdentif($2),getIdentif($2));FF;}
			|	IDENTIF MASMAS					{printf ("%s @ 1 + %s ! ",getIdentif($1),getIdentif($1));FF;}
			|	IDENTIF MENOSMENOS				{printf ("%s @ 1 - %s ! ",getIdentif($1),getIdentif($1));FF;}
			;

incremento_decremento_exp:	MENOSMENOS IDENTIF	{printf ("%s @ 1 - %s ! %s @ ",getIdentif($2),getIdentif($2),getIdentif($2));FF;} 
			|	MASMAS IDENTIF					{printf ("%s @ 1 + %s ! %s @ ",getIdentif($2),getIdentif($2),getIdentif($2));FF;}
			|	IDENTIF MASMAS					{printf ("%s @ 1 + %s ! %s @ ",getIdentif($1),getIdentif($1),getIdentif($1));FF;}
			|	IDENTIF MENOSMENOS				{printf ("%s @ 1 - %s ! %s @ ",getIdentif($1),getIdentif($1),getIdentif($1));FF;}
			;

asignacion:		IDENTIF '=' expresion			{printf("%s !\n",getIdentif($1));FF;}
			|	IDENTIF '[' expresion ']' 
					'=' expresion 				{printf("swap cells %s + !\n",getIdentif($1));FF;}
			|	IDENTIF '[' expresion ']'		{printf("%s",getDim($1));FF;}
					'[' expresion ']' 			{printf("+ ");FF;}
					'=' expresion				{printf("swap cells %s + !\n",getIdentif($1));FF;}
			;

fin_printf:		')' ';' 						{printf(".\n");FF;}
					codigo
			| 	/*lambda*/						{printf(". ");FF;} 
					',' expresion ')' ';' 		{printf(".\n");FF;}
					codigo
			;

finIf:			/*lambda*/						{printf("then \n");FF;}
					codigo
			|	ELSE 							{printf("else \n");FF;} 
					'{' codigo '}' 				{printf("then \n");FF;}
					codigo
		   ;

expresion:     termino								{ ; }
			|	expresion  '+' expresion			{printf("+ ");FF;}
			|	expresion  '-' expresion			{printf("- ");FF;}
			|	expresion  '*' expresion			{printf("* ");FF;}
			|	expresion  '/' expresion			{printf("/ ");FF;}
			|	expresion  EQUAL expresion			{printf("= ");FF;}
			|	expresion  NOT expresion			{printf("= 0= ");FF;}
			|	expresion  MENOREQUAL expresion		{printf("<= ");FF;}
			|	expresion  MAYOREQUAL expresion		{printf(">= ");FF;}
			|	expresion  '<' expresion			{printf("< ");FF;}
			|	expresion  '>' expresion			{printf("> ");FF;}
			|	expresion  '&' expresion			{printf("and ");FF;}
			|	expresion  '|' expresion			{printf("or ");FF;}
			|	expresion  ANDAND expresion			{printf("and ");FF;}
			|	expresion  OROR expresion			{printf("or ");FF;}
			|	expresion  '%' expresion			{printf("mod ");FF;}
             ;

termino:		operando							{ ; }
			|	'+' operando %prec SIGNO_UNARIO		{ ; }
			|	'-' operando %prec SIGNO_UNARIO		{printf("negate ");FF;}
			|	'!' expresion			          	{printf("0= ");FF;}
			;

operando:		IDENTIF 							{printf("%s @ ",getIdentif($1));FF;}
			|	NUMERO								{printf("%d ",$1);FF;}
			|	'(' expresion ')'					{ ; }
			|	IDENTIF '[' 						{printf("%s ",getIdentif($1));FF;} 
					expresion ']'   				{printf("%s",getDim(getIdentif($1)));FF;}
					fin_matrices					
			|	incremento_decremento_exp
			|	IDENTIF								{strcpy(pila_func[pos_contador_func],$1);pos_contador_func++;reiniciarAtrb($1);}
				'(' atributos  ')' 					{pos_contador_func--;}
													{printf("%s\n",$1);FF;} 
			;
			 
fin_matrices: 	/*lambda*/ 							{printf("cells + @ ");FF;}
			|	'[' expresion ']' 					{printf("+ cells + @ ");FF;}
			;

%%
                            // SECCION 4    Codigo en C
int n_linea = 1 ;

int yyerror (mensaje)
char *mensaje ;
{
    fprintf (stderr, "%s en la linea %d\n", mensaje, n_linea) ;
    printf ( "bye\n") ;
}

char *mi_malloc (int nbytes)       // reserva n bytes de memoria dinamica
{
    char *p ;
    static long int nb = 0;        // sirven para contabilizar la memoria
    static int nv = 0 ;            // solicitada en total

    p = malloc (nbytes) ;
    if (p == NULL) {
         fprintf (stderr, "No queda memoria para %d bytes mas\n", nbytes) ;
         fprintf (stderr, "Reservados %ld bytes en %d llamadas\n", nb, nv) ;
         exit (0) ;
    }
    nb += (long) nbytes ;
    nv++ ;

    return p ;
}


/***************************************************************************/
/********************** Seccion de Palabras Reservadas *********************/
/***************************************************************************/

typedef struct s_pal_reservadas { // para las palabras reservadas de C
    char *nombre ;
    int token ;
} t_reservada ;

t_reservada pal_reservadas [] = { // define las palabras reservadas y los
    "main",        MAIN,           // y los token asociados
    "int",         INTEGER,
    "puts",        PUTS,
    "do",          DO,
    "while",       WHILE,
    "==",          EQUAL,
    "!=",          NOT,
    ">=",          MAYOREQUAL,
    "<=",          MENOREQUAL,
    "&&",          ANDAND,
    "||",          OROR,
    "--",          MENOSMENOS,
    "++",          MASMAS,
    "if",          IF,
    "else",        ELSE,
    "printf",      PRINTF,
    "for",         FOR,
	"return",	RETURN,
    NULL,          0               // para marcar el fin de la tabla
} ;

t_reservada *busca_pal_reservada (char *nombre_simbolo)
{                                  // Busca n_s en la tabla de pal. res.
                                   // y devuelve puntero a registro (simbolo)
    int i ;
    t_reservada *sim ;

    i = 0 ;
    sim = pal_reservadas ;
    while (sim [i].nombre != NULL) {
           if (strcmp (sim [i].nombre, nombre_simbolo) == 0) {
                                         // strcmp(a, b) devuelve == 0 si a==b
                 return &(sim [i]) ;
             }
           i++ ;
    }

    return NULL ;
}

 
/***************************************************************************/
/******************* Seccion del Analizador Lexicografico ******************/
/***************************************************************************/

char *genera_cadena (char *nombre)     // copia el argumento a un
{                                      // string en memoria dinamica
      char *p ;
      int l ;

      l = strlen (nombre)+1 ;
      p = (char *) mi_malloc (l) ;
      strcpy (p, nombre) ;

      return p ;
}


int yylex ()
{
    int i ;
    unsigned char c ;
    unsigned char cc ;
    char ops_expandibles [] = "=<>!|&%+-*/" ;
    char cadena [256] ;
    t_reservada *simbolo ;

    do {
    	c = getchar () ;

		if (c == '#') {	// Ignora las lineas que empiezan por #  (#define, #include)
			do {		//	OJO que puede funcionar mal si una linea contiene #
			 c = getchar () ;	
			} while (c != '\n') ;
		}
		
		if (c == '/') {	// Si la linea contiene un / puede ser inicio de comentario
			cc = getchar () ;
			if (cc != '/') {   // Si el siguiente char es /  es un comentario, pero...
				ungetc (cc, stdin) ;
		 } else {
		     c = getchar () ;	// ...
		     if (c == '@') {	// Si es la secuencia //@  ==> transcribimos la linea
		          do {		// Se trata de codigo inline (Codigo Forth embebido en C)
		              c = getchar () ;
		              putchar (c) ;
		          } while (c != '\n') ;
		     } else {		// ==> comentario, ignorar la linea
		          while (c != '\n') {
		              c = getchar () ;
		          }
		     }
		 }
		}
		
		if (c == '\n')
		 n_linea++ ;
		
    } while (c == ' ' || c == '\n' || c == 10 || c == 13 || c == '\t') ;

    if (c == '\"') {
         i = 0 ;
         do {
             c = getchar () ;
             cadena [i++] = c ;
         } while (c != '\"' && i < 255) ;
         if (i == 256) {
              printf ("AVISO: string con mas de 255 caracteres en linea %d\n", n_linea) ;
         }		 	// habria que leer hasta el siguiente " , pero, y si falta?
         cadena [--i] = '\0' ;
         yylval.cadena = genera_cadena (cadena) ;
         return (STRING) ;
    }

    if (c == '.' || (c >= '0' && c <= '9')) {
         ungetc (c, stdin) ;
         scanf ("%d", &yylval.valor) ;
//         printf ("\nDEV: NUMERO %d\n", yylval.valor) ;        // PARA DEPURAR
         return NUMERO ;
    }

    if ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z')) {
         i = 0 ;
         while (((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') ||
                 (c >= '0' && c <= '9') || c == '_') && i < 255) {
             cadena [i++] = tolower (c) ;
             c = getchar () ;
         }
         cadena [i] = '\0' ;
         ungetc (c, stdin) ;

         yylval.cadena = genera_cadena (cadena) ;
         simbolo = busca_pal_reservada (yylval.cadena) ;
         if (simbolo == NULL) {    // no es palabra reservada -> identificador 
//               printf ("\nDEV: IDENTIF %s\n", yylval.cadena) ;    // PARA DEPURAR
               return (IDENTIF) ;
         } else {
//               printf ("\nDEV: OTRO %s\n", yylval.cadena) ;       // PARA DEPURAR
               return (simbolo->token) ;
         }
    }

    if (strchr (ops_expandibles, c) != NULL) { // busca c en ops_expandibles
         cc = getchar () ;
         sprintf (cadena, "%c%c", (char) c, (char) cc) ;
         simbolo = busca_pal_reservada (cadena) ;
         if (simbolo == NULL) {
              ungetc (cc, stdin) ;
              yylval.cadena = NULL ;
              return (c) ;
         } else {
              yylval.cadena = genera_cadena (cadena) ; // aunque no se use
              return (simbolo->token) ;
         }
    }

//    printf ("\nDEV: LITERAL %d #%c#\n", (int) c, c) ;      // PARA DEPURAR
    if (c == EOF || c == 255 || c == 26) {
//         printf ("tEOF ") ;                                // PARA DEPURAR
         return (0) ;
    }

    return c ;
}


int main ()
{
    yyparse () ;
}


