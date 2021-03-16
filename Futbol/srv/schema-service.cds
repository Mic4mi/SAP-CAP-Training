using {miFutbol as my} from '../db/schema';

service api {

    entity Partidos   as projection on my.Partidos;
    entity Resultados as projection on my.Resultados;
    entity Equipos    as projection on my.Equipos;
    entity Jugadores  as projection on my.Jugadores;
    entity Puntajes   as projection on my.Puntajes;
    entity Estadios   as projection on my.Estadios;
}
