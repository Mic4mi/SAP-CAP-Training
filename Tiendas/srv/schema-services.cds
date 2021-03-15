using {misTiendas as my} from '../db/schema';

service api {

    entity Tiendas           as
        select from my.Tiendas {
            *
        };

    entity Duenos            as
        select from my.Duenos {
            *
        };

    entity Productos         as
        select from my.Productos {
            *
        };

    entity Duenos_Tiendas    as
        select from my.Duenos_Tiendas {
            *
        };

    entity Tiendas_Productos as
        select from my.Tiendas_Productos {
            *
        };

    entity finalView         as
        select from Tiendas {
            name                      as nombreTienda,
            productos.productos.name  as productoNombre,
            productos.productos.valor as productoPrecio,
            duenos.duenos.name        as duenoNombre
        }
}
