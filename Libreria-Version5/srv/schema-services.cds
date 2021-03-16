using {miLibreria as my} from '../db/schema';

service api {

    entity Libros      as projection on my.Libros;
    entity Editoriales as projection on my.Editoriales;

    entity Clientes    as
        select from my.Clientes {
            *
    };

    entity Usuarios    as
        select from my.Usuarios {
            *
        };

    entity Autores     as
        select from my.Autores {
            *
        };

    entity resumen     as
        select from Clientes {
            librosComprados.nombre             as librosComprados,
            librosComprados.autor.nombre       as autores,
            librosComprados.autor.nacionalidad as nacionalidad_del_autor,
            librosComprados.editorial.nombre   as editorial
        };

}
