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

/*Pensamos que las tecnologias no tienen una relación explícita con
uno o varios proyectos, tampoco que están 'contenidas' por los mismos,
sino que los proyectos tienen o 'usan' varias tecnologías, de esta 
manera, en este caso, las declaramos sin una relación pero un proyecto
va a tener un array de tecnologias*/

entity Tecnologias : cuid {
    nombre  : String(111);
    salario : Decimal(7, 2); //per month, es mensual
}
