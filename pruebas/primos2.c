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
// -operador &&

// Resultado esperado:
// Imprime una lista de los numeros primos separados por '-'

#include <stdio.h>

int primo ;
int n  ;
int m ;

main ()
{
    int d ;
    int i ;
    int p ;

    i = 1 ; 
    n = 1 ; 
    m = 100 ;
    
    i = 1 ;
    do {  
        d = 2 ;
        primo = 1 ;
        while (primo && d<i) { 
            p = i % d ;
            if (p == 0) {
                primo = 0 ;
            }
            d = d + 1 ;
        }

        if (primo) {
            printf ("%d  ", i) ;
        }
//@  ." - " 
        i = i + 1 ;
    } while (i <= m) ;
    
//    system ("pause") ;
}
