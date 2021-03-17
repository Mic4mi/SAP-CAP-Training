using {miFutbol as my} from '../db/schema';

service api {

    entity Partidos               as projection on my.Partidos;
    entity Resultados             as projection on my.Resultados;
    entity Equipos                as projection on my.Equipos;
    entity Jugadores              as projection on my.Jugadores;
    entity Puntajes               as projection on my.Puntajes;
    entity Estadios               as projection on my.Estadios;

    entity goleadores             as
        select from Jugadores {
            nombre                                       as nombre_del_jugador,
            apodo                                        as apodo_del_jugador,
            parent.nombreEquipo                          as equipo_del_jugador,
            puntaje.partido.fecha                        as fecha_del_partido,
            puntaje.partido.estadio                      as estadio,
            puntaje.partido.equipoLocal.nombreEquipo     as equipo_local,
            puntaje.partido.equipoVisitante.nombreEquipo as equipo_visitante
        }
        where
            puntaje.goles >= 3;

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

}
