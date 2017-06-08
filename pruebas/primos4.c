// Uc3m - Ingenieria Informatica - 2016/2017
// David Morcuende Cantador 100330670
// Pablo Ramos de la Cal 100329993

// Bateria de pruebas de la practica final
// Prueba XX

// Comprueba:
// -funcion main
// -declaracion variables globales y locales
// -asignacion variables globales y locales
// -while
// -dowhile
// -if
// -printf
// -funciones varios parametros
// -return expresion

// Resultado esperado:
// Imprime una lista de los numeros primos y los que no lo son los imprime con '-'

#include <stdio.h>

int d ;
int n  ;
int m ;

esprimo (int n) 
{
    int primo ;
    int d ;

    primo = 1 ;
    d = 2 ;
    while (d < n) {
        if (n % d == 0) {
            primo = 0 ;
        }
        d = d + 1 ;
    }
    return (primo) ;        
}


listaprimos (int n, int m)
{
    while (n < m) {
        if (esprimo (n)) {
            printf ("%d  ", n) ;
        }
        n = n + 1 ;
//@  ." - " 
    } 
}


main ()
{
    int d ;
    int i ;

    listaprimos (1, 100) ;

//    system ("pause") ;
}
