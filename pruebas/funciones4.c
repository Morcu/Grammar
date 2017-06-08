// Uc3m - Ingenieria Informatica - 2016/2017
// David Morcuende Cantador 100330670
// Pablo Ramos de la Cal 100329993

// Bateria de pruebas de la practica final
// Prueba XX

// Comprueba:
// -funcion main
// -declaracion variables globales y locales
// -asignacion variables globales y locales
// -asignacion funcion
// -puts
// -printf
// -funcion con 2 parametros
// -return variable

// Resultado esperado:
// b es menor que a El menor es  3
// a es menor que b El menor es  3
// b es menor que a El menor es  4

#include <stdio.h>

int c ;

mifuncion (int a, int b) 
{
    int c ;
    
    if (a < b) {
       puts ("a es menor que b") ;
       c = a ;
    } else {
       puts ("b es menor que a") ;
       c = b ;
    }   
    return c ;
}



main ()
{
     int a ;
     int b ;
     
     a = 7 ;
     b = 3 ;
     c = mifuncion (a, b) ;
     puts ("El menor es ") ;
     printf ("%d\n", c) ;
//@ cr     
     a = 3 ;
     b = 7 ;
     c = mifuncion (a, b) ;
     puts ("El menor es ") ;
     printf ("%d\n", c) ;
//@ cr     
     a = 4 ;
     b = 4 ;
     c = mifuncion (a, b) ;
     puts ("El menor es ") ;
     printf ("%d\n", c) ;

//   system("pause") ;
 }
