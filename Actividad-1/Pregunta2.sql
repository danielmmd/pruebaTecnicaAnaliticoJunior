# 2. Cuáles son los productos que han tenido mayor venta y a qué vendedor pertenece?

WITH 
-- Ventas con información del producto y vendedor
ventas_detalladas AS (
    SELECT 
        dv.IdProducto,
        p.Nombre AS NombreProducto,
        dv.IdFactura,
        dv.Cantidad,
        dv.Total,
        v.Vendedor AS IdVendedor
    FROM TblDetalleVenta dv
    INNER JOIN TblProducto p ON dv.IdProducto = p.IdProducto
    INNER JOIN TblVenta v ON dv.IdFactura = v.IdFactura
),

-- Suma total de ventas por producto y vendedor
ventas_por_producto_vendedor AS (
    SELECT 
        vd.IdProducto,
        vd.NombreProducto,
        vd.IdVendedor,
        SUM(vd.Total) AS TotalVentas,
        SUM(vd.Cantidad) AS TotalCantidad
    FROM ventas_detalladas vd
    GROUP BY vd.IdProducto, vd.NombreProducto, vd.IdVendedor
),

-- Obtener el máximo total de ventas entre todos los productos
maxima_venta AS (
    SELECT MAX(TotalVentas) AS MaxVenta
    FROM ventas_por_producto_vendedor
)

-- Consulta final: productos con el mayor total vendido
SELECT 
    vppv.NombreProducto,
    vppv.TotalVentas,
    vppv.TotalCantidad,
    vend.Nombre1 || ' ' || vend.Apellido1 AS NombreVendedor,
    vend.Identificacion
FROM ventas_por_producto_vendedor vppv
INNER JOIN maxima_venta mv ON vppv.TotalVentas = mv.MaxVenta
INNER JOIN TblVendedor vend ON vppv.IdVendedor = vend.Identificacion
ORDER BY vppv.TotalVentas DESC;
