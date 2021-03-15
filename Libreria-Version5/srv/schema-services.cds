using {miLibreria as my} from '../db/schema';

service api {

    entity Libros    as projection on my.Libros;
    entity Autores   as projection on my.Autores;
    entity Editorial as projection on my.Editorial;

    //    entity Clientes  as projection on my.Clientes;
    entity Clientes  as
        select from my.Clientes {
            *
        };

    entity Usuarios  as
        select from my.Usuarios {
            *
        };

}
