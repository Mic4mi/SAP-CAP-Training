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
    marca   : Association to Marcas;
    subtipo : Association to one Subtipos
                  on subtipo.producto = $self;
}

entity Marcas : cuid {
    nombre    : String(50);
    pais      : String(50);
    productos : Association to many Productos
                    on productos.marca = $self;
}

entity Tipos : cuid {
    nombre   : String(111);
    subtipos : Association to many Subtipos
                   on subtipos.tipo = $self;

}

entity Subtipos : cuid {
    nombre   : String(111);
    tipo     : Association to Tipos;
    producto : Association to Productos;
}

entity Duenos_Tiendas : cuid {
    key duenos  : Association to Duenos;
    key tiendas : Association to Tiendas;
}

entity Tiendas_Productos : cuid {
    key tienda    : Association to Tiendas;
    key productos : Association to Productos;
}
