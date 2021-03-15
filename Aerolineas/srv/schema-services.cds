using {misAerolineas as my} from '../db/schema';

service api {

    entity Aerolineas              as
        select from my.Aerolineas {
            *
        };

    entity Aeropuertos             as
        select from my.Aeropuertos {
            *
        };

    entity Aviones                 as
        select from my.Aviones {
            *
        };

    entity Vuelos                  as
        select from my.Vuelos {
            *
        };

    entity Pasajeros               as
        select from my.Pasajeros {
            *
        };

    entity Aeropuertos_Vuelos      as
        select from my.Aeropuertos_Vuelos {
            *
        };

    entity Equipaje                as
        select from my.Equipaje {
            *
        };

    entity aerolineasView          as
        select from Aerolineas {
            *,
            nombre         as nombreAerolinea,
            aviones.modelo as nombreAvion,
            vuelos.nombre  as nombreVuelo,
        };

    entity mayoresDe30             as
        select * from Pasajeros
        where
            edad > 30;

    entity pasajerosFranceses      as
        select * from Vuelos
        where
            pasajeros.pais.code = 'FRA';

    entity vuelosArgentinosBaratos as
        select * from Vuelos[paisDeOrigen.code = 'ARG'
    ]
    where
        valor < 1000;

}
