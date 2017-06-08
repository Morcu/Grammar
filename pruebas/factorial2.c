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
// -*=
// -while
// -printf

// Resultado esperado:
// main_n=6 main_resultado=7 
// main_n=5 main_resultado=42 
// main_n=4 main_resultado=210 
// main_n=3 main_resultado=840 
// main_n=2 main_resultado=2520 
// main_n=1 main_resultado=5040 
// 5040

#include <stdio.h>

main ()
{
    int resultado ;
    int n ;

    n=7 ;
    resultado=1 ;

    while (n>1) {
        resultado=resultado*n;
        n--;

//@ ." main_n=" main_n @ .
//@ ." main_resultado=" main_resultado @ . cr

    }
    printf("%d\n", resultado) ;
    
//    system ("pause") ;
}
