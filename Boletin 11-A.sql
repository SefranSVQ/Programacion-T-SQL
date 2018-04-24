-- Boletin 11. En la base de datos NorthWind. Para comprobar si una tabla existe puedes utilizar la función OBJECT_ID

use Northwind
go

/* 

- Función inline: 
- Comentario: 
- Precondiciones: 
- Entradas: 
- Salidas:
- E/S:
- Postcondiciones:

*/

-- 1. Deseamos incluir un producto en la tabla Products llamado "Cruzcampo lata” pero no estamos seguros si se ha insertado o no.
-- El precio son 4,40, el proveedor es el 16, la categoría 1 y la cantidad por unidad es "Pack 6 latas” 
-- "Discontinued” toma el valor 0 y el resto de columnas se dejarán a NULL.
-- Escribe un script que compruebe si existe un producto con ese nombre. 
-- En caso afirmativo, actualizará el precio y en caso negativo insertarlo. 

if exists (select ProductName from Products where ProductName = @Producto)
	begin
		print 'Producto existente. Se actualizará su precio.'
		update Products
		set UnitPrice = 4.40 where ProductName = @Producto
	end
else
	begin
		print 'Producto no existente. Se insertará una nueva columna.'
		insert into Products
		values(@Producto, 16, 1, 'Pack 6 latas', 4.40, null, null, 0, 0)
	end


-- 2. Comprueba si existe una tabla llamada ProductSales. Esta tabla ha de tener de cada producto el ID, 
-- el Nombre, el Precio unitario, el número total de unidades vendidas y el total de dinero 
-- facturado con ese producto. Si no existe, créala

if OBJECT_ID(N'ProductSales') is not null
	begin
		print 'La tabla existe.'
	end
else
	begin
		print 'La tabla no existe. Se procederá a crearla.'
		create table ProductSales (
			ID int not null 
				constraint PK_ProductSales Primary key,
			Nombre varchar (25) not null, 
			PrecioUnitario money not null, 
			UnidadesVendidas int, 
			DineroFacturado money
		)
	end

-- 3. Comprueba si existe una tabla llamada ShipShip. Esta tabla ha de tener de cada Transportista el ID, 
-- el Nombre de la compañía, el número total de envíos que ha efectuado y el número de países 
-- diferentes a los que ha llevado cosas. Si no existe, créala.

if object_id (N'ShipShip') is null
	begin
		print 'La tabla no existe. Se procederá a crearla.'
		create table ShipShip(
			ID char(5) not null 
				constraint PK_ShipShip primary key, 
			NombreCompañia varchar(25) not null, 
			TotalEnvios int, 
			TotalPaisesDeDistribucion int
		)
	end
else 
	begin
		print 'La tabla ya existe.'
	end

-- 4. Comprueba si existe una tabla llamada EmployeeSales. Esta tabla ha de tener de cada empleado su ID, 
--  el Nombre completo, el número de ventas totales que ha realizado, el número de clientes diferentes 
--  a los que ha vendido y el total de dinero facturado. Si no existe, créala.

if object_id (N'EmployeeSales') is null
	begin
		print 'La tabla no existe. Se procederá a crearla.'
		create table EmployeeSales(
			ID char(5)
				constraint PK_EmployeeSales primary key, 
			Nombre varchar(15), 
			Apellidos varchar (25), 
			TotalVentas int, 
			CantidadDistintosClientes int, 
			TotalFacturado money)
	end
else 
	begin
		print 'La tabla ya existe.'
	end

go
-- 5. Entre los años 96 y 97 hay productos que han aumentado sus ventas y otros que las han disminuido. 
--	Queremos cambiar el precio unitario según la siguiente tabla:

-- Incremento de ventas		Incremento de precio
--		Negativo					-10%
--	  Entre 0 y 10%				  No varía
--	  Entre 10% y 50%				+5%
--    Mayor del 50%      10% con un máximo de 2,25


create view Ventas96_97 as 
	select PRO.ProductID, Ventas1996.Ventas as Ventas96, 
	Ventas1997.Ventas as Ventas97, isnull((Ventas1997.Ventas*100/Ventas1996.Ventas)-100, 100) as DiferenciaPorcentual
	from Products as PRO
	left join (
		select OD.ProductID, sum(Quantity) as Ventas from [Order Details] as OD
		inner join Orders as ORD on OD.OrderID = ORD.OrderID
		where year(ORD.OrderDate) = 1997 
		group by OD.ProductID
	) as Ventas1997 on PRO.ProductID = Ventas1997.ProductID
	left join (
		select OD.ProductID, sum(Quantity) as Ventas from [Order Details] as OD
		inner join Orders as ORD on OD.OrderID = ORD.OrderID
		where year(ORD.OrderDate) = 1996 
		group by OD.ProductID
	) as Ventas1996 on PRO.ProductID = Ventas1996.ProductID
go

begin transaction
-- no funciona, salta restriccion CK_Products_UnitsPrice (No entiendo el porqué, ninguna operación da un resultado negativo)
UPDATE Products
SET UnitPrice = CASE 
	WHEN Ventas96_97.DiferenciaPorcentual < 0 THEN UnitPrice*0.9
	WHEN Ventas96_97.DiferenciaPorcentual between 0 and 10 THEN UnitPrice
	WHEN Ventas96_97.DiferenciaPorcentual between 10 and 50 THEN UnitPrice*1.05
	ELSE CASE
		WHEN UnitPrice-UnitPrice*1.10 > 2.25 THEN UnitPrice+2.25
		ELSE UnitPrice-UnitPrice*1.10
	END
END
FROM Ventas96_97

rollback
