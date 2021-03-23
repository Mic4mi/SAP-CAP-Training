using {
    cuid,
    managed
} from '@sap/cds/common';


namespace misProyectos;

entity Clientes : cuid {
    razonSocial : String(111);
    proyectos   : Association to many Proyectos
                      on proyectos.cliente = $self;
}

/*La complejidad del proyecto se ve representada por los periodos
de tiempo que puede llegar a ocupar, estableciendo bajo como 1 mes,
medio como 6 meses y alto como 1 año. La dificultad se mide en que,
cuanto más complejo es el proyecto, más tiempo dura*/

entity Proyectos : cuid, managed {
    @mandatory cliente     : Association to Clientes;
    @mandatory tecnologias : array of String(111);
    dificultad             : Integer enum {
        bajo  = 1; //1 mes
        medio = 3; //6 meses
        alto  = 5; //1 año
    };
}

entity Tecnologias : cuid {
    nombre  : String(111);
    salario : Decimal(7, 2);
}
