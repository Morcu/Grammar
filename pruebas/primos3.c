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
// -vectores globales

// Resultado esperado:
// Imprime una lista de los numeros primos separados por '-'

#include <stdio.h>

int primos [100] ;
int m ;

main ()
{
    int v ;
    int i ;

    m = 100 ;

    i = 1 ; 
    while (i <= m) { 
        primos [i] = 1 ;
        i = i + 1 ;
    }

    i = 2 ; 
    while (i <= m) { 
        v = i * 2 ;
        while (v <= m) { 
            primos [v] = 0 ;
            v = v + i ;
        }
        i = i + 1 ;
    }

    i = 1 ; 
    while (i <= m) { 
        if (primos [i] == 1) {
            printf (" %d  ", i) ;
        }
//@ ." - "
        i = i + 1 ;
    }
}
