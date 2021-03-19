using {misTiendas as my} from '../db/schema';

service api {

    entity Tiendas                 as
        select from my.Tiendas {
            *
        };

    entity Duenos                  as
        select from my.Duenos {
            *
        };

    entity Productos               as
        select from my.Productos {
            *
        };

    entity Tipos                   as
        select from my.Tipos {
            *
        };

    entity Subtipos                as
        select from my.Subtipos {
            *
        };

    entity Marcas                  as
        select from my.Marcas {
            *
        };

    entity Duenos_Tiendas          as
        select from my.Duenos_Tiendas {
            *
        };

    entity Tiendas_Productos       as
        select from my.Tiendas_Productos {
            *
        };

    entity finalView               as
        select from Tiendas {
            name                      as nombreTienda,
            productos.productos.name  as productoNombre,
            productos.productos.valor as productoPrecio,
            duenos.duenos.name        as duenoNombre
        };

    entity fullProducto            as
        select from Productos {
            name                as nombreProducto,
            marca.nombre        as marca,
            subtipo.nombre      as subtipo,
            subtipo.tipo.nombre as tipo
        };

    entity filtrarTipoPanificacion as
        select * from Productos
        where
            subtipo.tipo.nombre = 'panificacion';

    entity filtrarSubtipofacturas  as
        select * from Productos
        where
            subtipo.nombre = 'facturas';

    entity filtrarMarcaBimbo       as
        select * from Productos
        where
            marca.nombre = 'Bimbo';

    entity rangoDePrecios          as
        select * from Productos
        where
                valor > 20
            and valor < 50;


    action modificarPrecio(productoID : Productos : ID, precio : Productos : valor) returns String;
    action controlDeStock(producto_tienda_ID : Tiendas_Productos : ID, cantidad : Integer) returns String;
}
