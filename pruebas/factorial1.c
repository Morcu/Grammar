// Uc3m - Ingenieria Informatica - 2016/2017
// David Morcuende Cantador 100330670
// Pablo Ramos de la Cal 100329993

// Bateria de pruebas de la practica final
// Prueba XX

// Comprueba:
// -funcion main
// -definicion variables
// -asignaciones variables
// -expresion
// -while
// -printf

// Resultado esperado:
// 540


#include <stdio.h>
main ()
{
    int resultado ;
    int n ;

    n=7 ;
    resultado=1 ;

    while (n>1) {
        resultado = resultado * n;
        n = n - 1 ;

//@ ." main_n=" main_n @ .
//@ ." main_resultado=" main_resultado @ . cr

    }
    printf("%d\n", resultado) ;
    
}
