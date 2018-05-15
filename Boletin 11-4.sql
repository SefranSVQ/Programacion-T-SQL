/*
Bolet�n 11.4 Procedimientos
Sobre la base de datos CentroDeportivo.
*/

use CentroDeportivo
go

/*
Ejercicio 1
Escribe un procedimiento EliminarUsuario que reciba como par�metro 
el DNI de un usuario, le coloque un NULL en la columna Sex y borre 
todas las reservas futuras de ese usuario. Ten en cuenta que si 
alguna de esas reservas tiene asociado un alquiler de material 
habr� que borrarlo tambi�n.
*/

select * from Usuarios
select * from Reservas

go

create procedure eliminarUsuario
	@DNI char(9)
as
begin

	begin transaction

		delete from ReservasMateriales
		where CodigoReserva in (
			select R.Codigo from Reservas as R 
			inner join Usuarios as U on R.ID_Usuario = U.ID
			where ID_Usuario = @DNI and R.Fecha_Hora > CURRENT_TIMESTAMP
			)

		delete from Reservas
		where Codigo in (
			select R.Codigo from Reservas as R 
			inner join Usuarios as U on R.ID_Usuario = U.ID
			where ID_Usuario = @DNI and R.Fecha_Hora > CURRENT_TIMESTAMP
		)

		update Usuarios
		set Sex = null
		where DNI = @DNI

	commit

end

go


begin transaction
	declare @DNI char(9)
	execute eliminarUsuario @DNI = '22222222A'
rollback
commit

go

/*
Ejercicio 2
Escribe un procedimiento que reciba como par�metros el c�digo de 
una instalaci�n y una fecha/hora (SmallDateTime) y devuelva en 
otro par�metro de salida el ID del usuario que la ten�a alquilada 
si en ese momento la instalaci�n estaba ocupada. Si estaba libre, 
devolver� un NULL.
*/

create procedure

/*
Ejercicio 3
Escribe un procedimiento que reciba como par�metros el c�digo de 
una instalaci�n y dos fechas (DATE) y devuelva en otro par�metro 
de salida el n�mero de horas que esa instalaci�n ha estado alquilada 
entre esas dos fechas, ambas incluidas. Si se omite la segunda fecha, 
se tomar� la actual con GETDATE(). Devuelve con return c�digos de 
error si el c�digo de la instalaci�n es err�neo o si la fecha
de inicio es posterior a la de fin.
*/

/*
Ejercicio 4
Escribe un procedimiento EfectuarReserva que reciba como par�metro 
el DNI de un usuario, el c�digo de la instalaci�n, la fecha/hora
de inicio de la reserva y la fecha/hora final. El procedimiento 
comprobar� que los datos de entradas son correctos y grabar� la 
correspondiente reserva. Devolver� el c�digo de reserva generado 
mediante un par�metro de salida. Para obtener el valor generado 
usar la funci�n @@identity tras el INSERT. Devuelve un cero si 
la operaci�n se realiza con �xito y un c�digo de error seg�n 
la lista siguiente:

3: La instalaci�n est� ocupada para esa fecha y hora
4: El c�digo de la instalaci�n es incorrecto
5: El usuario no existe
8: La fecha/hora de inicio del alquiler es posterior a la de fin
11: La fecha de inicio y de fin son diferentes

*/