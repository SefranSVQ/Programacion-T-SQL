-- Boletin 11.0
-- Sobre la base de datos LeoTurf

-- 1.Crea una funci�n inline llamada FnCarrerasCaballo que reciba un rango de fechas (inicio y fin) 
--	y nos devuelva el n�mero de carreras disputadas por cada caballo entre esas dos fechas. 
--	Las columnas ser�n ID (del caballo), nombre, sexo, fecha de nacimiento y n�mero de carreras disputadas.

-- 2.Crea una funci�n escalar llamada FnTotalApostadoCC que reciba como par�metros el ID de un caballo 
--	y el ID de una carrera y nos devuelva el dinero que se ha apostado a ese caballo en esa carrera.

-- 3.Crea una funci�n escalar llamada FnPremioConseguido que reciba como par�metros el ID de una apuesta 
--	y nos devuelva el dinero que ha ganado dicha apuesta. Si todav�a no se conocen las posiciones 
--	de los caballos, devolver� un NULL

-- 4.El procedimiento para calcular los premios en las apuestas de una carrera 
--	(los valores que deben figurar en la columna Premio1 y Premio2) es el siguiente:

	-- a. Se calcula el total de dinero apostado en esa carrera

	-- b. El valor de la columna Premio1 para cada caballo se calcula dividiendo el total 
	--	de dinero apostado entre lo apostado a ese caballo y se multiplica el resultado por 0.6

	-- c. El valor de la columna Premio2 para cada caballo se calcula dividiendo el total de
	--  dinero apostado entre lo apostado a ese caballo y se multiplica el resultado por 0.2

	-- d. Si a alg�n caballo no ha apostado nadie tanto el Premio1 como el Premio2 se ponen a 100.

	-- Crea una funci�n que devuelva una tabla con tres columnas: ID de la apuesta, Premio1 y Premio2.
	-- Debes usar la funci�n del Ejercicio 2. Si lo estimas oportuno puedes crear otras funciones para realizar parte de los c�lculos.

-- 5.Crea una funci�n FnPalmares que reciba un ID de caballo y un rango de fechas y nos devuelva 
--	el palmar�s de ese caballo en ese intervalo de tiempo. El palmar�s es el n�mero de victorias, 
--	segundos puestos, etc. Se devolver� una tabla con dos columnas: Posici�n y NumVeces, que indicar�n, 
--	respectivamente, cada una de las posiciones y las veces que el caballo ha obtenido ese resultado. 
--	Queremos que aparezcan 8 filas con las posiciones de la 1 a la 8. Si el caballo nunca ha finalizado 
--	en alguna de esas posiciones, aparecer� el valor 0 en la columna NumVeces.

-- 6.Crea una funci�n FnCarrerasHipodromo que nos devuelva las carreras celebradas en un hip�dromo en 
--	un rango de fechas. La funci�n recibir� como par�metros el nombre del hip�dromo y la fecha de inicio 
--	y fin del intervalo y nos devolver� una tabla con las siguientes columnas: 
--	Fecha de la carrera, n�mero de orden, numero de apuestas realizadas, n�mero de caballos inscritos,
--	n�mero de caballos que la finalizaron y nombre del ganador.

-- 7.Crea una funci�n FnObtenerSaldo a la que pasemos el ID de un jugador y una fecha y 
-- nos devuelva su saldo en esa fecha. Si se omite la fecha, se devolver� el saldo actual