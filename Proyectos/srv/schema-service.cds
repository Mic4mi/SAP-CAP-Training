using {misProyectos as my} from '../db/schema';

service api {
    entity Clientes    as projection on my.Clientes;
    entity Proyectos   as projection on my.Proyectos;
    entity Tecnologias as projection on my.Tecnologias;
    action calcularCosto(proyectoID : Proyectos : ID) returns String;
}
