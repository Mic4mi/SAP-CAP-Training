using {
    cuid,
    Country,
    Currency,
    managed,
    Language
} from '@sap/cds/common';

namespace miLibreria;

type Nombre : String(50);
type Apellido : String(50);
type Fecha : Date;

aspect datosDeUsuario {
    username : String(111);
    password : String(8);
}

aspect NombreEntidad {
    @mandatory nombre : Nombre;
}

entity Libros : cuid, NombreEntidad {
    fechaDePublicacion : Fecha;
    @mandatory puntaje : Integer;
    criticas           : array of {
        critico        : Nombre;
        critica        : String(300);
    }
}

entity Clientes : cuid, NombreEntidad {
    @mandatory fechaNacimiento : Fecha;
    @mandatory dni             : Integer; //No mostrar en el servicio
    usuario                    : Composition of one Usuarios
                                     on usuario.parent = $self;
}

entity Usuarios : cuid, datosDeUsuario {
    key parent     : Association to Clientes;
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
    ventaDirecta               : Boolean;
}

entity Editorial : cuid, NombreEntidad {
    nacionalidad : String(50);
}
