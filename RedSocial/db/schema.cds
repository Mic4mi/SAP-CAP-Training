using {
    Country,
    Currency,
    managed,
    Language
} from '@sap/cds/common';

namespace miRedSocial;

type correoElectronico : {
    usuario : String(50);
    dominio : String(50);
    full    : String(100);
};

aspect Usuario_Humano {
    nombre            : String(111)       @mandatory;
    apellido          : String(111)       @mandatory;
    paisDeOrigen      : String(3);
    email             : correoElectronico @mandatory;
    genero            : Integer enum {
        Femenino  = 1;
        Masculino = 2;
        Otro      = 3;
    };
    telefono          : String(30);
    fechaDeNacimiento : Date              @mandatory;
}

entity Usuarios : Usuario_Humano {
    key ID            : Integer;
        username      : String(30)@mandatory;
        password      : String(8) @mandatory;
        amigos        : Integer;
        estado        : Boolean;
        mensajes      : Composition of many Mensajes
                            on mensajes.parent = $self;
        publicaciones : Association to many Publicaciones
                            on publicaciones.usuario = $self;
        comentarios   : Association to many Comentarios
                            on comentarios.usuario = $self;
        perfil        : Association to one Perfiles
                            on perfil.usuario = $self;
}

entity Mensajes {
    key ID              : Integer;
        parent          : Association to Usuarios;
        nombreRemitente : String(30)@mandatory;
        contenido       : String(300);
        leido           : Boolean;
        multimedia      : array of {
            tipo        : String(100);
            tamanio     : Integer;
        }
}

entity Perfiles {
    key ID            : Integer;
        titulo        : String(50) default 'titulo';
        descripcion   : String(150);
        categoria     : Integer enum {
            Bronce   = 1;
            Plata    = 2;
            Oro      = 3;
            Diamante = 4;
            Carbon   = 0;
        };
        usuario       : Association to Usuarios;
        publicaciones : Association to many Publicaciones
                            on publicaciones.perfil = $self;
}

entity Publicaciones : managed {
    key ID                        : Integer;
        tituloPublicacion         : String(50);
        cantidadDeVecesCompartido : Integer;
        tipo                      : Integer enum {
            texto = 1;
            foto  = 2;
            video = 3;
            url   = 4;
        };
        vistaPrevia               : Boolean;
        likes                     : Integer;
        usuario                   : Association to Usuarios;
        perfil                    : Association to Perfiles;
        comentarios               : Association to many Comentarios
                                        on comentarios.publicacion = $self;
}

entity Comentarios : managed {
    key ID          : Integer;
        contenido   : String(300);
        usuario     : Association to Usuarios;
        publicacion : Association to Publicaciones;
}
