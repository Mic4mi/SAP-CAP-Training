using {cuid} from '@sap/cds/common';


namespace misEmpresas;

entity Empresas : cuid {
    name      : String(111);
    empleados : Composition of many Empleados
                    on empleados.parent = $self;

}

entity Empleados : cuid {
    key parent : Association to Empresas;
        name   : String(111);
        sector : String(111);
}
