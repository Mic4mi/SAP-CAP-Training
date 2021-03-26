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
    key ID                  : Integer;
        fechaDeLaOrden      : DateTime;
        fechaRequerida      : DateTime;
        fechaDeEnvio        : DateTime;
        codigoShipVia       : Integer;
        transporte          : Decimal;
        nombreDelTransporte : String(111);
        direccionDeEnvio    : String(111);
        ciudadDeEnvio       : String(111);
        regionDeEnvio       : String(111);
        codigoPortalDeEnvio : String(111);
        paisDeEnvio         : String(111);
}

entity Order_Details: cuid {
    OrderID   : Integer;
    ProductID : Integer;
    UnitPrice : Decimal;
    Quantity  : Integer;
    Discount  : Integer;
}

//Primero cargar las entidades
