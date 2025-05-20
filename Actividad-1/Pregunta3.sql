# 3. Construya una consulta general que involucre todas las tablas del Modelo Relacional y permita visualizar totales en ella.
WITH 
-- Detalle de cada venta con sus productos y totales
detalle_venta AS (
    SELECT 
        dv.IdDetalleFactura,
        dv.IdFactura,
        dv.IdProducto,
        dv.Cantidad,
        dv.Total,
        p.Nombre AS NombreProducto,
        p.Precio,
        p.UnidadDeMedida,
        p.StockMinimo,
        p.StockMaximo,
        c.Descripcion AS Categoria
    FROM TblDetalleVenta dv
    INNER JOIN TblProducto p ON dv.IdProducto = p.IdProducto
    INNER JOIN TblCategoria c ON p.IdCategoria = c.IdCategoria
),

-- Datos del vendedor de cada factura
venta_con_vendedor AS (
    SELECT 
        v.IdFactura,
        v.Fechas,
        v.Iva,
        v.IdTienda,
        vend.Identificacion,
        vend.Nombre1,
        vend.Apellido1
    FROM TblVenta v
    INNER JOIN TblVendedor vend ON v.Vendedor = vend.Identificacion
),

-- Conceptos asociados a los productos (si aplican)
conceptos AS (
    SELECT 
        cd.IdDetalleConcepto,
        cd.NombreConcepto AS NombreConceptoDetalle,
        c.NombreConcepto AS NombreConcepto,
        cd.Descripcion,
        cd.Activo
    FROM TblConceptoDetalle cd
    INNER JOIN TblConcepto c ON cd.IdConcepto = c.IdConcepto
)

-- Consulta final: consolidado por factura
SELECT 
    vcv.IdFactura,
    vcv.Fechas,
    vcv.Nombre1 || ' ' || vcv.Apellido1 AS NombreVendedor,
    dv.NombreProducto,
    dv.Categoria,
    dv.Cantidad,
    dv.Total,
    vcv.Iva,
    (dv.Total + vcv.Iva) AS TotalConIVA
FROM venta_con_vendedor vcv
INNER JOIN detalle_venta dv ON vcv.IdFactura = dv.IdFactura
ORDER BY vcv.IdFactura;
