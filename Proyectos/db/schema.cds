using {managed} from '@sap/cds/common';

namespace misProyectos;

entity Clientes {
    key ID          : Integer;
        razonSocial : String(111);
        proyectos   : Association to Proyectos;

}

entity Proyectos : managed {
    key ID          : Integer;
        // cliente     : Association to Clientes;
        tecnologias : array of Integer;
        dificultad  : Integer enum {
            bajo  = 1;
            medio = 3;
            alto  = 5;
        };
}

entity Tecnologias {
    key ID      : Integer;
        nombre  : String(111);
        salario : Decimal(7, 2);
}
