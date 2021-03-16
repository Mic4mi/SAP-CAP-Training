using {
    cuid,
    Country,
    Currency,
    managed,
    Language
} from '@sap/cds/common';

namespace miFutbol;

type Fecha : Date;


entity Partidos : cuid {
    espectadores  : Integer;
    nombreArbitro : String(60);
    nombreRelator : String(60);
    fecha         : Fecha;
    esClasico     : Boolean;
    resultado     : Composition of one Resultados
                        on resultado.parent = $self;
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
}

entity Jugadores : cuid {
    key parent       : Association to Equipos;
        nombre       : String(111);
        valor        : Integer;
        apodo        : String(50);
        posicion     : String(50);
        paisDeOrigen : String(3);
        numero       : Integer;
}

entity Estadios : cuid {
    nombre    : String(50);
    direccion : String(100);
    capacidad : Integer;
}

entity Puntajes : cuid {
    goles       : Integer;
    asistencias : Integer;
    salvadas    : Integer;
}
