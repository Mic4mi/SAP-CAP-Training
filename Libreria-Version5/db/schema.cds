using {
    cuid,
    Country,
    Currency,
    managed,
    Language
} from '@sap/cds/common';

namespace miLibreria;

type correoElectronico : {
    name   : String(20);
    domain : String(111);
}


type Nombre : String(50);
type Apellido : String(50);
type Fecha : Date;

aspect NombreEntidad {
    nombre : Nombre;
}

entity Libros : cuid, NombreEntidad {
    fechaDePublicacion : Fecha;
    puntaje            : Integer;
    criticas           : array of {
        critico        : Nombre;
        critica        : String(300);
    };
    editorial          : Association to Editoriales;
    autor              : Association to Autores;
    clientes           : Association to Clientes;
}

entity Clientes : cuid, NombreEntidad {
    fechaNacimiento : Fecha;
    dni             : Integer; //No mostrar en el servicio
    usuario         : Composition of one Usuarios
                          on usuario.parent = $self;
    librosComprados : Association to many Libros
                          on librosComprados.clientes = $self;
}

entity Usuarios : cuid {
    key parent     : Association to Clientes;
        username   : String(111);
        password   : String(8); // no mostrar
        email      : array of {
            user   : String(30);
            domain : String(30);
            full   : String(60);
        };
        puntos     : Integer;
        estado     : Integer enum {
            activo    = 1;
            baja      = 2;
            pendiente = 3;
        };
}

entity Autores : cuid, NombreEntidad {
    genero                     : String(2);
    fechaNacimiento            : Fecha;
    nacionalidad               : String(50);
    cantidadDeLibrosPublicados : Integer;
    ventaDirecta               : Boolean; //no mostrar
    editorial                  : Association to Editoriales;
    libros                     : Association to many Libros
                                     on libros.autor = $self;
}

entity Editoriales : cuid, NombreEntidad {
    nacionalidad : String(50);
    libros       : Association to many Libros
                       on libros.editorial = $self;
    autores      : Association to many Autores
                       on autores.editorial = $self;
}
