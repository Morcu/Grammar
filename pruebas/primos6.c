// Uc3m - Ingenieria Informatica - 2016/2017
// David Morcuende Cantador 100330670
// Pablo Ramos de la Cal 100329993

// Bateria de pruebas de la practica final
// Prueba XX

// Comprueba:
// -funcion main
// -declaracion variables globales y locales
// -asignacion variables globales y locales
// -if
// -printf
// -for
// -variable++

// Resultado esperado:
// Imprime una lista de los numeros primos y los que no lo son los imprime con '-'

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
    
    for (i = 1 ; i <= m ; i++) {  
        primo = 1 ;
        for (d = 2 ; d < i ; d++) {
            if (i % d == 0) {
                primo = 0 ;
            }
        }

        if (primo) {
            printf ("%d  ", i) ;
        }

//@  ." - " 
//        i = i + 1 ;
    }
}
