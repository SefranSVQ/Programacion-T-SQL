-- Boletin 11.0
-- Sobre la base de datos LeoTurf

/* La Plantisha

- Función [tipo]: 
- Comentario: 
- Cabecera:
- Precondiciones: 
- Entradas: 
- Salidas:
- E/S:
- Postcondiciones:

*/

SET dateformat 'dMy'
use leoturf
go

-- 1.Crea una función inline llamada FnCarrerasCaballo que reciba un rango de fechas (inicio y fin) 
--	y nos devuelva el número de carreras disputadas por cada caballo entre esas dos fechas. 
--	Las columnas serán ID (del caballo), nombre, sexo, fecha de nacimiento y número de carreras disputadas.

/*

- Función In-Line: FnCarrerasCaballo
- Comentario: Esta función nos devolverá una tabla con los valores
	ID del caballo, nombre, sexo, fecha de nacimiento y número de carreras disputadas
	entre 2 fechas dadas.

- Precondiciones: las fechas deben ser válidas
- Entradas: FechaInicio (tipo fecha), FechaFin (tipo fecha)
- Salidas: Tabla con ID del caballo, nombre, sexo, fecha de nacimiento y número de carreras disputadas
- E/S: no hay.
- Postcondiciones: Se habrá mostrado por pantalla una tabla con los valores
	ID del caballo, nombre, sexo, fecha de nacimiento y número de carreras disputadas
	entre llas 2 fechas dadas.

*/


alter function FnCarrerasCaballo ( @fechaInicio date, @fechaFin date ) 
returns table as 
return (

	select CAB.ID, CAB.Nombre, CAB.Sexo, CAB.FechaNacimiento, COUNT(CAR.ID) as NumCarreras from LTCaballos as CAB
	left join LTCaballosCarreras as CABCAR on CAB.ID = CABCAR.IDCaballo
	left join LTCarreras as CAR on CABCAR.IDCarrera = CAR.ID
	where CAR.Fecha between @fechaInicio and @fechaFin
	group by CAB.ID, CAB.Nombre, CAB.Sexo, CAB.FechaNacimiento

)

go

select * from FnCarrerasCaballo('11-01-2018','10-12-2018')

-- 2.Crea una función escalar llamada FnTotalApostadoCC que reciba como parámetros el ID de un caballo 
--	y el ID de una carrera y nos devuelva el dinero que se ha apostado a ese caballo en esa carrera.

/*

- Función Escalar: FnTotalApostadoCC
- Comentario: Esta función calculará la cantidad monetaria apostada	
	por un caballo en una carrera determinada.
- Cabecera: FnTotalApostadoCC (@IDCaballo smallint, @IDCarrera smallint)
- Precondiciones: las entradas deben ser valores positivos.
- Entradas: IDCarrera (smaillint), IDCaballo (smallint)
- Salidas: DineroApostado (money)
- E/S: no hay.
- Postcondiciones: se habrá devuelvo la cantidad monetaria total 
	apostada por el caballo dado y en la carrera dada.

*/

go
CREATE FUNCTION FnTotalApostadoCC (@IDCaballo smallint, @IDCarrera smallint) 
RETURNS money AS 
BEGIN 
	
	DECLARE @dinero money

	set @dinero = (
		select SUM(importe) from LTApuestas as APU
		where IDCaballo = @IDCaballo and IDCarrera = @IDCarrera
	)

	RETURN @dinero

END
go

print FnTotalApostadoCC(1,1)

-- 3.Crea una función escalar llamada FnPremioConseguido que reciba como parámetros el ID de una apuesta 
--	y nos devuelva el dinero que ha ganado dicha apuesta. Si todavía no se conocen las posiciones 
--	de los caballos, devolverá un NULL

/* 

- Función Escalar: FnPremioConseguido
- Comentario: esta función devolverá el premio de una apuesta dada. 
	Si la carrera no ha finalizado, se devolverá null.
- Cabecera: FnPremioConseguido (@IDApuesta int)
- Precondiciones: el ID de la carrera debe ser un valor positivo.
- Entradas: IDApuesta (int)
- Salidas: Premio (money)
- E/S: no hay
- Postcondiciones: Se habrá devuelto el premio de una carrera dada. 
	Si la carrera no ha finalizado, se devolverá null.

*/

go

create function FnPremioConseguido (@IDApuesta int)
returns int as 
begin
	declare @premio money

	if (
		select CABCAR.Posicion from LTApuestas as APU
		inner join LTCaballosCarreras as CABCAR on APU.IDCaballo = CABCAR.IDCaballo and APU.IDCarrera = CABCAR.IDCarrera
		where APU.ID = 1
	
	) = 1
	begin
		set money = ( -- mal
			select CABCAR.Premio1 from LTApuestas as APU
			inner join LTCaballosCarreras as CABCAR on APU.IDCaballo = CABCAR.IDCaballo and APU.IDCarrera = CABCAR.IDCarrera
			where APU.ID = 1
		)
	end
	else if (
			select CABCAR.Posicion from LTApuestas as APU
			inner join LTCaballosCarreras as CABCAR on APU.IDCaballo = CABCAR.IDCaballo and APU.IDCarrera = CABCAR.IDCarrera
			where APU.ID = 1
	
		) = 2
		begin

		end
		else set money = null


return @premio
end

go


-- 4.El procedimiento para calcular los premios en las apuestas de una carrera 
--	(los valores que deben figurar en la columna Premio1 y Premio2) es el siguiente:

	-- a. Se calcula el total de dinero apostado en esa carrera

	-- b. El valor de la columna Premio1 para cada caballo se calcula dividiendo el total 
	--	de dinero apostado entre lo apostado a ese caballo y se multiplica el resultado por 0.6

	-- c. El valor de la columna Premio2 para cada caballo se calcula dividiendo el total de
	--  dinero apostado entre lo apostado a ese caballo y se multiplica el resultado por 0.2

	-- d. Si a algún caballo no ha apostado nadie tanto el Premio1 como el Premio2 se ponen a 100.

	-- Crea una función que devuelva una tabla con tres columnas: ID de la apuesta, Premio1 y Premio2.
	-- Debes usar la función del Ejercicio 2. Si lo estimas oportuno puedes crear otras funciones para realizar parte de los cálculos.

-- 5.Crea una función FnPalmares que reciba un ID de caballo y un rango de fechas y nos devuelva 
--	el palmarés de ese caballo en ese intervalo de tiempo. El palmarés es el número de victorias, 
--	segundos puestos, etc. Se devolverá una tabla con dos columnas: Posición y NumVeces, que indicarán, 
--	respectivamente, cada una de las posiciones y las veces que el caballo ha obtenido ese resultado. 
--	Queremos que aparezcan 8 filas con las posiciones de la 1 a la 8. Si el caballo nunca ha finalizado 
--	en alguna de esas posiciones, aparecerá el valor 0 en la columna NumVeces.

-- 6.Crea una función FnCarrerasHipodromo que nos devuelva las carreras celebradas en un hipódromo en 
--	un rango de fechas. La función recibirá como parámetros el nombre del hipódromo y la fecha de inicio 
--	y fin del intervalo y nos devolverá una tabla con las siguientes columnas: 
--	Fecha de la carrera, número de orden, numero de apuestas realizadas, número de caballos inscritos,
--	número de caballos que la finalizaron y nombre del ganador.

-- 7.Crea una función FnObtenerSaldo a la que pasemos el ID de un jugador y una fecha y 
-- nos devuelva su saldo en esa fecha. Si se omite la fecha, se devolverá el saldo actual