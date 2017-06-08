// Uc3m - Ingenieria Informatica - 2016/2017
// David Morcuende Cantador 100330670
// Pablo Ramos de la Cal 100329993

// Bateria de pruebas de la practica final
// Prueba XX

// Comprueba:
// -funcion main
// -declaracion variables
// -asignacion variables
// -asignacion funcion
// -printf
// -puts
// -funcion sin parametros
// -return expresion

// Resultado esperado:
// 124

#include <stdio.h>

mifuncion () 
{
    int c ;
    c = 123 ; 
    puts ("Prueba") ;
    return c+1 ;
}

main ()
{
     int c ; 
     c = mifuncion () ;
//@ cr     
     printf ("%d\n", c) ;
 }
