using {
    cuid,
    Currency
} from '@sap/cds/common';


namespace misTiendas;

aspect Precio {
    moneda : Currency;
    valor  : Decimal(5, 2);
};

entity Tiendas : cuid {
    name      : String(111);
    duenos    : Association to many Duenos_Tiendas
                    on duenos.tiendas = $self;
    productos : Association to many Tiendas_Productos
                    on productos.tienda = $self;
}

entity Duenos : cuid {
    name    : String(111);
    tiendas : Association to many Duenos_Tiendas
                  on tiendas.duenos = $self;
}

entity Productos : cuid, Precio {
    name    : String(111);
    tiendas : Association to many Tiendas_Productos
                  on tiendas.productos = $self;
}

entity Duenos_Tiendas : cuid {
    key duenos  : Association to Duenos;
    key tiendas : Association to Tiendas;
}

entity Tiendas_Productos : cuid {
    key tienda    : Association to Tiendas;
    key productos : Association to Productos;
}
