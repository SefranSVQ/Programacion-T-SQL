/*

1. Crea una función a la que pasemos un intervalo de tiempo y nos devuelva una tabla con el Happy day 
(el día que más ha ganado) y el black day (el día que más ha perdido) de cada jugador. 
Si hay más de un día en que haya ganado o perdido el máximo, tomaremos el más reciente. 
Columnas: ID del jugador, nombre, apellidos, fecha del happy day, cantidad ganada, fecha del black day, cantidad perdida.

*/

/*
2.Se ha creado un coeficiente para valorar los caballos. Su valor se calcula sumando el 
número de carreras ganadas multiplicado por cinco más el número de carreras en las que 
ha quedado segundo multiplicado por tres. El resultado se divide entre el número de 
carreras disputadas multiplicado por 0,2. Al resultado de todo eso de lo multiplica 
por un coeficiente de edad que se calcula según la tabla siguiente:


Edad					Valor

Seis o menos años		100

Siete					90

Ocho o nueve			75

Diez					65

Más de diez				40

*/

/*

3.Queremos saber la cantidad de dinero en apuestas que mueve cada hipódromo. Haz una función 
a la que se le pase un rango de fechas y nos devuelva el dinero movido en apuestas en cada 
hipódromo entre esas fechas. También queremos saber cuál fue la apuesta más alta de ese periodo. 
Considerar solo las apuestas, no los premios. Columnas: Nombre del hipódromo, cantidad gestionada, 
fecha de la apuesta más alta, importe de la apuesta más alta y otra columna que tomará 
los valores G,C o P según si esa apuesta acertó el primero (Ganador), 
el segundo (Colocado) o no obtuvo premio (Pierde).

*/

/*

4.Haz una función DescalificaCaballo que reciba como parámetros el ID de un Caballo y 
en ID de una carrera y descalifique a ese caballo en esa carrera. Eso puede dar lugar, 
si el caballo quedó primero o segundo, a que haya que alterar los premios obtenidos.

	a.Si el caballo descalificado fue primero: Crear apuntes para descontar los premios 
	obtenidos por los que apostaron por él, anular también los apuntes de los que 
	apostaron por el segundo, que ahora pasa a ser primero y generar los apuntes 
	correspondientes al nuevo premio. Crear los apuntes correspondientes al segundo 
	premio para los que apostaron por el tercero, que ahora pasa a ser segundo.

	b.Si el caballo descalificado fue segundo: Anular las ganancias de los que apostaron 
	por él. Crear los apuntes correspondientes al segundo premio para los que 
	apostaron por el tercero, que ahora pasa a ser segundo.

La función nos devolverá los apuntes que haya que insertar en la tabla Apuntes. 
No se borra ningún apunte. Los que ya no sirvan se crea uno con el importe opuesto.

*/