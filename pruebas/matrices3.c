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
// -funcion sin parametros

// Resultado esperado:
// Imprime dos matrices sin inicializar (lo que haya en esas direcciones) 
// y dos inicializadas, una normal y otra transpuesta

#include <stdio.h>

int mimatriz [5][5] ;
int i ;
int j ;
int aux;

int inicializa ()
{
	int i ;
	int j ;

	i = 0 ;
	while (i < 5) {
		j = 0 ;
		while (j < 5) {
			mimatriz [i][j] = i + 2*j ;
			j = j + 1 ;
		}
		i = i + 1 ;
	}	
}


int imprime () 
{
	i = 0 ;
	while (i < 5) {
		j = 0 ;
		while (j < 5) {
			printf ("%d ", mimatriz [i][j]) ;
			j = j + 1 ;
		}
		puts ("\n") ;    // Esto igual no funiona en Forth, se simula con la siguiente embebida
//@ cr
		i = i + 1 ;
	}
}


int transpuesta () 
{
    int i ;
    int j ;
    int aux ;
    
    i = 0 ;
    do {
       j = i+1 ; 
       while (j < 5) {
           aux = mimatriz [i][j] ;
           mimatriz [i][j] = mimatriz [j][i] ;
           mimatriz [j][i] = aux ;
           j = j +1 ;
       } 
       i = i + 1 ;
    } while  (i < 5) ;
}


main () {
	puts ("Matriz sin inicializar ") ;
//@ cr
	imprime () ;
	inicializa () ;
//@ cr
	puts ("Matriz inicializada ") ;
//@ cr
	imprime () ;
	transpuesta () ;
//@ cr
	puts ("Matriz transpuesta ") ;
//@ cr
	imprime () ;
	
//    system ("pause") ;
}
