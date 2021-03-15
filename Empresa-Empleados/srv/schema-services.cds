using {misEmpresas as my} from '../db/schema';

service api {

    entity Empresas  as
        select from my.Empresas {
            *
        };

    entity Empleados as
        select from my.Empleados {
            *
        };

}
