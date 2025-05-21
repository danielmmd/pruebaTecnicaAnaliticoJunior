
**4. ¿Cuáles son algunas estrategias que usarías para optimizar el rendimiento de consultas SQL en grandes conjuntos de datos?**

Durante mi experiencia previa en Bancolombia, tuve la oportunidad de trabajar directamente con grandes volúmenes de datos en los distintos ambientes de la LZ
(landing zone), por lo que aprendí a implementar varias estrategias efectivas para optimizar el rendimiento de consultas SQL, 
entre ellas:

1. **Uso de particiones en tablas históricas:**
   Muchas de las tablas se encontraban particionadas por campos como año o mes. Aprovechar estas particiones aplicando 
   filtros explícitos (`WHERE año = '2023' AND mes = '05'`) reducía significativamente el volumen de datos escaneado y 
   mejoraba el tiempo de respuesta.

2. **Creación de tablas temporales en ambientes controlados:**
   Para evitar consultar directamente sobre tablas históricas muy pesadas, era común crear tablas intermedias o temporales con filtros específicos,
    en ambientes de pruebas que tenían políticas de retención (como meses o incluso horas dependiendo del la zona). 
    Esto permitía realizar análisis y desarrollo sin afectar la performance de la zona de aterrizaje (*Landing Zone*).

3. **Uso moderado y estratégico de subconsultas con `WITH` (CTEs):**
   Las *Common Table Expressions* permitían modularizar y separar la lógica de la consulta principal. 
   Si bien tenían un límite (que depende del motor SQL usado), su uso moderado hacía el código más legible y, en muchos casos, 
   evitaba la repetición de cálculos costosos.

4. **Control del volumen de datos extraídos:**
   Estábamos alineados con buenas prácticas de gobernanza de datos, lo que implicaba no sobrepasar ciertos umbrales al consultar la LZ. 
   Siempre aplicábamos filtros, proyecciones selectivas (evitando `SELECT *`) y
   condiciones de partición para no comprometer el rendimiento de la infraestructura.

5. **Evaluación previa del impacto de las consultas:**
   Se podían utilizar comandos como `EXPLAIN` o herramientas integradas en el motor de consultas (como Hive, Presto o BigQuery) 
   para obtener estadísticas sobre el plan de ejecución de la consulta, el volumen de datos estimado, el tipo de *join* utilizado y 
   posibles *bottlenecks* antes de ejecutarla en producción.

6. **Uso de índices y ordenamiento en tablas cuando el motor lo permite:**
   Aunque no siempre aplicable en todos los sistemas distribuidos, en algunos motores SQL (como PostgreSQL o MySQL) 
   se pueden crear índices o aprovechar columnas *clustered* para acelerar búsquedas frecuentes.

7. **Evitar transformaciones innecesarias en tiempo de consulta:**
   En lugar de aplicar funciones complejas sobre columnas directamente en la consulta, 
   se prefería crear tablas preprocesadas con campos ya transformados si iban a ser utilizadas repetidamente.

8. **Joins eficientes y eliminación de duplicados tempranos:**
   En joins de muchas tablas, se cuidaba el orden de unión, la cardinalidad y se aplicaban filtros antes del join cuando fuera posible. 
   Además, se eliminaban duplicados lo antes posible con `DISTINCT` o agregaciones.

---


Estas estrategias no solo buscan mejorar el tiempo de respuesta, 
sino también garantizar la estabilidad de la infraestructura, evitando sobrecargar zonas críticas como la LZ. 
Toda optimización parte del entendimiento del motor SQL específico (Hive, SparkSQL, Presto, etc.) y del diseño del *data lake* o *data warehouse* en uso.

---


