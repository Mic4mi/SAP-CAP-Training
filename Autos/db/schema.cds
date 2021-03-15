using {cuid} from '@sap/cds/common';


namespace misAutos;

entity Marcas : cuid {
    name    : String(111);
    country : String(111);
    comment : String(111);
    models  : Association to many Modelos
                  on models.marca = $self;
}

entity Modelos : cuid {
    name  : String(111);
    type  : String(111);
    marca : Association to Marcas;
}


