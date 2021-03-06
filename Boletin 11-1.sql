/*

1. Crea una funci�n a la que pasemos un intervalo de tiempo y nos devuelva una tabla con el Happy day 
(el d�a que m�s ha ganado) y el black day (el d�a que m�s ha perdido) de cada jugador. 
Si hay m�s de un d�a en que haya ganado o perdido el m�ximo, tomaremos el m�s reciente. 
Columnas: ID del jugador, nombre, apellidos, fecha del happy day, cantidad ganada, fecha del black day, cantidad perdida.

*/

/*
2.Se ha creado un coeficiente para valorar los caballos. Su valor se calcula sumando el 
n�mero de carreras ganadas multiplicado por cinco m�s el n�mero de carreras en las que 
ha quedado segundo multiplicado por tres. El resultado se divide entre el n�mero de 
carreras disputadas multiplicado por 0,2. Al resultado de todo eso de lo multiplica 
por un coeficiente de edad que se calcula seg�n la tabla siguiente:


Edad					Valor

Seis o menos a�os		100

Siete					90

Ocho o nueve			75

Diez					65

M�s de diez				40

*/

/*

3.Queremos saber la cantidad de dinero en apuestas que mueve cada hip�dromo. Haz una funci�n 
a la que se le pase un rango de fechas y nos devuelva el dinero movido en apuestas en cada 
hip�dromo entre esas fechas. Tambi�n queremos saber cu�l fue la apuesta m�s alta de ese periodo. 
Considerar solo las apuestas, no los premios. Columnas: Nombre del hip�dromo, cantidad gestionada, 
fecha de la apuesta m�s alta, importe de la apuesta m�s alta y otra columna que tomar� 
los valores G,C o P seg�n si esa apuesta acert� el primero (Ganador), 
el segundo (Colocado) o no obtuvo premio (Pierde).

*/

/*

4.Haz una funci�n DescalificaCaballo que reciba como par�metros el ID de un Caballo y 
en ID de una carrera y descalifique a ese caballo en esa carrera. Eso puede dar lugar, 
si el caballo qued� primero o segundo, a que haya que alterar los premios obtenidos.

	a.Si el caballo descalificado fue primero: Crear apuntes para descontar los premios 
	obtenidos por los que apostaron por �l, anular tambi�n los apuntes de los que 
	apostaron por el segundo, que ahora pasa a ser primero y generar los apuntes 
	correspondientes al nuevo premio. Crear los apuntes correspondientes al segundo 
	premio para los que apostaron por el tercero, que ahora pasa a ser segundo.

	b.Si el caballo descalificado fue segundo: Anular las ganancias de los que apostaron 
	por �l. Crear los apuntes correspondientes al segundo premio para los que 
	apostaron por el tercero, que ahora pasa a ser segundo.

La funci�n nos devolver� los apuntes que haya que insertar en la tabla Apuntes. 
No se borra ning�n apunte. Los que ya no sirvan se crea uno con el importe opuesto.

*/