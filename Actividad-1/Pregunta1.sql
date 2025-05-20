
#1) ¿ Cuáles son las ventas de cada uno de los productos vendidos por categoría y 
#     por cada uno de los vendedores, indique aquí los nombres de estado civil sexo y 
#     tipo de identificación de cada vendedor en la consulta.?

#1) R/ 
WITH 
-- Información de productos con su categoría
productos_categorias AS (
    SELECT 
        p.IdProducto,
        p.Nombre AS NombreProducto,
        c.Descripcion AS Categoria
    FROM TblProducto p
    INNER JOIN TblCategoria c ON p.IdCategoria = c.IdCategoria
),

-- Detalle de ventas unidas a productos y categorías
detalle_ventas_productos AS (
    SELECT 
        dv.IdFactura,
        dv.IdProducto,
        dv.Cantidad,
        dv.Total,
        pc.NombreProducto,
        pc.Categoria
    FROM TblDetalleVenta dv
    INNER JOIN productos_categorias pc ON dv.IdProducto = pc.IdProducto
),

-- Información de ventas unida a vendedores
ventas_vendedores AS (
    SELECT 
        v.IdFactura,
        vend.Identificacion,
        vend.Nombre1,
        vend.Nombre2,
        vend.Apellido1,
        vend.Apellido2,
        vend.TipoDeIdentificacion,
        vend.EstadoCivil,
        vend.Sexo
    FROM TblVenta v
    INNER JOIN TblVendedor vend ON v.Vendedor = vend.Identificacion
)

-- Consulta final: ventas por producto, categoría y vendedor
SELECT 
    dvp.NombreProducto,
    dvp.Categoria,
    vv.Nombre1 || ' ' || vv.Apellido1 AS NombreVendedor,
    vv.TipoDeIdentificacion,
    vv.EstadoCivil,
    vv.Sexo,
    SUM(dvp.Cantidad) AS TotalCantidadVendida,
    SUM(dvp.Total) AS TotalVentas
FROM detalle_ventas_productos dvp
INNER JOIN ventas_vendedores vv ON dvp.IdFactura = vv.IdFactura
GROUP BY 
    dvp.NombreProducto,
    dvp.Categoria,
    vv.Nombre1,
    vv.Apellido1,
    vv.TipoDeIdentificacion,
    vv.EstadoCivil,
    vv.Sexo
ORDER BY dvp.Categoria, NombreVendedor;
