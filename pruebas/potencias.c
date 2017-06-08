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
// -printf
// -vetores

// Resultado esperado:
// Imprime una lista de laspotencias de 2 desde 2 hasta 1073741824

#include <stdio.h>

int potencias [100] ;
int m ;

main ()
{
    int i ;

    m = 30 ;

    i = 1 ; 
    potencias [0] = 1 ;
    while (i <= m) { 
        potencias [i] = potencias [i-1] * 2 ;
        i = i + 1 ;
    }

    i = 1 ; 
    while (i <= m) { 

        printf (" %d  ", potencias [i]) ;
//@  cr
        i = i + 1 ;
    }
}
