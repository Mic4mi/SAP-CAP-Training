using {misVeterinarias as my} from '../db/schema';

service api {

    entity Sucursales           as
        select from my.Sucursales {
            *
        };

    entity Medicos_Veterinarios as
        select from my.Medicos_Veterinarios {
            *
        };

    entity Mascotas             as
        select from my.Mascotas {
            *
        };

    entity Duenios              as
        select from my.Duenios {
            *
        };

    entity Duenios_Mascotas     as
        select from my.Duenios_Mascotas {
            *
        };

    entity Vacunas              as
        select from my.Vacunas {
            *
        };

    entity sucuarsalesView      as
        select from Sucursales {
            nombre              as sucursalNombre,
            veterinarios.nombre as nombreVeterinarios,
        //veterinarios.mascotas.nombre as mascotas //Problemas al acceder a este dato
        };

    entity mascotasView         as
        select from Mascotas {
            nombre                             as nombreMascota,
            Mascotas.nombreRaza                as raza,
            duenios.duenio.nombre              as nombreDuenio,
            vacunas.nombre                     as vacunas,
            medico_veterinario.nombre          as veterinario,
            medico_veterinario.sucursal.nombre as sucursal
        }

}
