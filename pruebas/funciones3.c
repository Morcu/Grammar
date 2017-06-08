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
// -funcion con un parametro
// -return expresion

// Resultado esperado:
// El cuadrado de  7  es  49 
// El cuadrado de  12  es  144

#include <stdio.h>

cuadrado (int a) 
{
    int c ;
    c = a * a ;    
    return c ;
}

main ()
{
     int a ;
     int c ;
     a = 7 ;
     puts ("El cuadrado de ") ;
     printf ("%d", a) ;
     c = cuadrado (a) ;
     puts (" es ") ;
     printf ("%d\n", c) ;
//@ cr     
     a = 12 ;
     puts ("El cuadrado de ") ;
     printf ("%d", a) ;
     puts (" es ") ;
     printf ("%d\n", cuadrado (a)) ;
//@ cr     

}
