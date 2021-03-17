using {
    cuid,
    Country,
    Currency,
    managed,
    Language
} from '@sap/cds/common';

namespace miFutbol;

type Fecha : Date;
 
entity Partidos : cuid, managed {
    espectadores    : Integer;
    nombreArbitro   : String(60);
    nombreRelator   : String(60);
    fecha           : Fecha;
    esClasico       : Boolean;
    resultado       : Composition of one Resultados
                          on resultado.parent = $self;
    equipoLocal     : Association to Equipos;
    equipoVisitante : Association to Equipos;
    puntajes        : Association to many Puntajes
                          on puntajes.partido = $self;
    estadio         : Association to Estadios;
}

entity Resultados : cuid {
    key parent             : Association to Partidos;
        resultadoLocal     : Integer;
        resultadoVisitante : Integer;
}

entity Equipos : cuid {
    nombreEquipo         : String(50);
    division             : String(50);
    puntosDelTorneoLocal : String(50);
    cantidadDeJugadores  : Integer;
    presupuesto          : Integer;
    jugadores            : Composition of many Jugadores
                               on jugadores.parent = $self;
    local                : Association to many Partidos
                               on local.equipoLocal = $self;
    visitante            : Association to many Partidos
                               on visitante.equipoVisitante = $self;
    estadio              : Association to one Estadios
                               on estadio.equipo = $self;
    puntajes             : Association to many Puntajes
                               on puntajes.equipo = $self;
}

entity Jugadores : cuid {
    key parent       : Association to Equipos;
        nombre       : String(111);
        valor        : Integer;
        apodo        : String(50);
        posicion     : String(50);
        paisDeOrigen : String(3);
        numero       : Integer;
        puntaje      : Association to one Puntajes
                           on puntaje.jugador = $self;
}

entity Estadios : cuid {
    nombre    : String(50);
    direccion : String(100);
    capacidad : Integer;
    partidos  : Association to many Partidos
                    on partidos.estadio = $self;
    equipo    : Association to Equipos;
}

entity Puntajes : cuid {
    goles       : Integer;
    asistencias : Integer;
    salvadas    : Integer;
    partido     : Association to Partidos;
    jugador     : Association to Jugadores;
    equipo      : Association to Equipos;
}
