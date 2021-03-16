using {miRedSocial as my} from '../db/schema';

service api {

    entity Usuarios               as projection on my.Usuarios;
    entity Mensajes               as projection on my.Mensajes;
    entity Perfiles               as projection on my.Perfiles;
    entity Publicaciones          as projection on my.Publicaciones;
    entity Comentarios            as projection on my.Comentarios;


    //Una vista donde un perfil nos muestre su usuario con sus publicaciones.

    entity perfilCompleto  as
        select from Perfiles {
            *,
            usuario.username                    as nombre_de_usuario,
            publicaciones.tituloPublicacion     as titulo_de_la_publicacion,
            //publicaciones.comentarios.contenido
        };

    /*
    Una vista que nos permita ver los usuarios provenientes
    de Argentina que tengan más de 200 amigos.
     */

    entity argentinosPopulares    as
        select * from Usuarios[paisDeOrigen = 'ARG'
    ]
    where
        amigos > 200;

    /*
    Una vista que nos permita ver las publicaciones que han
    sido compartidas más de 100 veces y el nombre de usuario
    que la compartió.
    */
    entity publicacionesPopulares as
        select
            *,
            Publicaciones.usuario.nombre as nombre_Usuario
        from Publicaciones
        where
            cantidadDeVecesCompartido > 100;

}
