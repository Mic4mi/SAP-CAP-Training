using {cuid} from '@sap/cds/common';

namespace northwindApp;

entity Productos {
    key ID                 : Integer;
        nombre             : String(111);
        cantidadxunidad    : String(111);
        precioUnitario     : Decimal;
        unidadesEnStock    : Integer;
        unidadesEnUnaOrden : Integer;
        reordenarNivel     : Integer;
        decontinuado       : Boolean;
}

entity Ordenes {
    key ID                     : Integer;
        fechaDeLaOrden         : DateTime;
        fechaRequerida         : DateTime;
        fechaDeEnvio           : DateTime;
        codigoShipVia          : Integer;
        transporte             : Decimal;
        nombreDelTransporte    : String(111);
        direccionDeEnvio       : String(111);
        ciudadDeEnvio          : String(111);
        regionDeEnvio          : String(111);
        codigoPortalDeEnvio    : String(111);
        paisDeEnvio            : String(111);
        informacionAdicionalID : String(111);
        /*detalles                : Association to many Order_Details
                                     on detalles = $self;*/
}

entity Order_Details : cuid {
    orden          : Association to Ordenes;
    producto       : Association to Productos;
    precioUnitario : Decimal;
    cantidad       : Integer;
    descuento      : Decimal;
}

