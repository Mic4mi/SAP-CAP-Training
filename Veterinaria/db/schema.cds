using {
    cuid,
    Country
} from '@sap/cds/common';

namespace misVeterinarias;

aspect Raza {
    nombreRaza : String(111);
    especie    : String(111);
}

aspect direccion {
    calle                          : String(111);
    ciudad                         : String(111);
    @assert.integrity : false pais : Country;
}

entity Medicos_Veterinarios : cuid {
    nombre          : String(111);
    sucursal        : Association to Sucursales;
    fechaNacimiento : Date;
    cuil            : Integer64;
    mascotas        : Association to many Mascotas
                          on mascotas.medico_veterinario = $self;
}

entity Sucursales : cuid, direccion {
    nombre       : String(111);
    veterinarios : Association to many Medicos_Veterinarios
                       on veterinarios.sucursal = $self;
}

entity Mascotas : cuid, Raza {
    nombre             : String(111);
    fechaNacimiento    : Date;
    sexo               : String(2);
    medico_veterinario : Association to Medicos_Veterinarios;
    vacunas            : Composition of many Vacunas
                             on vacunas.parent = $self;
    duenios            : Association to many Duenios_Mascotas
                             on duenios.mascota = $self;
}

entity Vacunas : cuid {
    key parent : Association to Mascotas;
        nombre : String(111);
        fecha  : Date;
}

entity Duenios : cuid {
    nombre   : String(111);
    telefono : Integer64;
    dni      : Integer64;
    mascotas : Association to many Duenios_Mascotas
                   on mascotas.duenio = $self;
}

entity Duenios_Mascotas : cuid {
    key duenio  : Association to Duenios;
    key mascota : Association to Mascotas;
}
