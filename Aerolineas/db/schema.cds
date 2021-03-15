using {
    cuid,
    Country,
    Currency,
    managed,
    Language
} from '@sap/cds/common';


namespace misAerolineas;

type Nombre : String(30);

aspect Direccion {
    calle                          : String(111);
    ciudad                         : String(111);
    @assert.integrity : false pais : Country;
}

aspect Precio {
    valor  : Decimal(7, 3);
    moneda : Currency;
}

aspect Procedencia {
    @assert.integrity : false paisDeOrigen : Country;
    ciudadDeOrigen                         : String(30);
    fechaSalida                            : Date;
    horaDeSalida                           : Time;
}

aspect Destino {
    @assert.integrity : false paisDeDestino : Country;
    ciudadDestino                           : String(30);
    fechaLlegada                            : Date;
    horaDeLlegada                           : Time;
}

entity Aerolineas : cuid {
    nombre                                 : Nombre;
    @assert.integrity : false paisDeOrigen : Country;
    aviones                                : Association to many Aviones
                                                 on aviones.aerolineas = $self;
    vuelos                                 : Association to many Vuelos
                                                 on vuelos.aerolinea = $self;
}

entity Aeropuertos : cuid {
    nombre                              : Nombre;
    @assert.integrity : false ubicacion : Country;
    aviones                             : Association to many Aviones
                                              on aviones.aeropuerto = $self;
    vuelos                              : Association to many Aeropuertos_Vuelos
                                              on vuelos.aeropuertos = $self;
}

entity Aviones : cuid {
    modelo     : Nombre;
    hechoEn    : Country;
    aeropuerto : Association to Aeropuertos;
    aerolineas : Association to Aerolineas;
    vuelos     : Association to many Vuelos
                     on vuelos.avion = $self;
}

entity Vuelos : cuid, managed, Procedencia, Destino, Precio {
    nombre              : Nombre;
    aerolinea           : Association to Aerolineas;
    aeropuertos         : Association to many Aeropuertos_Vuelos
                              on aeropuertos.vuelos = $self;
    avion               : Association to Aviones;
    asientosDisponibles : Integer;
    status              : Integer enum {
        enCurso   = 1;
        enTierra  = 2;
        cancelado = 3;
        demorado  = 4;
    };
    pasajeros           : Association to many Pasajeros
                              on pasajeros.vuelo = $self;
    lenguaje            : Language;
}

entity Pasajeros : cuid, Direccion {
    vuelo        : Association to Vuelos;
    nombre       : Nombre;
    dni          : String(9);
    nroPasaporte : String(10);
    edad         : Integer;
    ocupacion    : String(30);
    email        : Composition of many {
                       usuario : String(100);
                       dominio : String(100);
                       full    : String(100);
                   }
    equipaje     : Composition of many Equipaje
                       on equipaje.parent = $self;
}

entity Equipaje : cuid {
    key parent : Association to Pasajeros;
        peso   : Decimal(7, 3);
        tipo   : String(50);
}

entity Aeropuertos_Vuelos : cuid {
    key aeropuertos : Association to Aeropuertos;
    key vuelos      : Association to Vuelos;
}
