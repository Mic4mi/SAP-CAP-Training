using {miFutbol as my} from '../db/schema';

service api {

    entity Partidos               as projection on my.Partidos;
    entity Resultados             as projection on my.Resultados;
    entity Equipos                as projection on my.Equipos;
    entity Jugadores              as projection on my.Jugadores;
    entity Puntajes               as projection on my.Puntajes;
    entity Estadios               as projection on my.Estadios;


    /*Una vista que desde jugador nos muestre los
    partidos en los que anoto más de 3 goles*/

    entity goleadores             as
        select from Jugadores {
            nombre                                       as nombre_del_jugador,
            apodo                                        as apodo_del_jugador,
            parent.nombreEquipo                          as equipo_del_jugador,
            puntaje.partido.fecha                        as fecha_del_partido,
            puntaje.partido.estadio.nombre               as estadio,
            puntaje.partido.equipoLocal.nombreEquipo     as equipo_local,
            puntaje.partido.equipoVisitante.nombreEquipo as equipo_visitante
        }
        where
            puntaje.goles >= 3;

    /*Una vista para que podamos ver los partidos que
    terminaron en goleada (3 o mas goles de diferencia)*/

    entity partidosEnGoleada      as
        select from Partidos {
            *
        }
        where
            (
                resultado.resultadoLocal - resultado.resultadoVisitante
            ) >= 3
            or (
                resultado.resultadoVisitante - resultado.resultadoLocal
            ) >= 3;

    /*Una vista donde podemos ver el arquero
    con mas salvadas de la liga*/

    entity arquerosConMasSalvadas as
        select from Jugadores {
            *,
            puntaje.salvadas as arqueroAtajadas,
        }
        where
            posicion = 'arquero'
        order by
            arqueroAtajadas desc
        limit 1;

    //Resumen de los partidos

    entity vistaFinal             as
        select from Partidos {
            fecha                        as fecha_del_partido,
            estadio.nombre               as estadio,
            nombreArbitro                as arbitro,
            equipoLocal.nombreEquipo     as equipo_local,
            resultado.resultadoLocal     as resultado_equipo_local,
            equipoVisitante.nombreEquipo as equipo_visitante,
            resultado.resultadoVisitante as resultado_equipo_visitante
        };

}
