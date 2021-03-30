using {northwindApp as my} from '../db/schema';

@(path : '/AuthService')
service AuthService @(requires : 'Scope2') {
    entity Productos     as projection on my.Productos;
    entity Ordenes       as projection on my.Ordenes;
    entity Order_Details as projection on my.Order_Details;
}

@(path : '/AdminService')
service AdminService @(requires : 'Scope1') {
    entity Productos     as projection on my.Productos;
    entity Ordenes       as projection on my.Ordenes;
    entity Order_Details as projection on my.Order_Details;
}

@(path : '/GeneralReadOnly')
service generalReadOnly @(_requires : 'Scope1') {
    @readonly
    entity Productos     as projection on my.Productos;

    @readonly
    entity Ordenes       as projection on my.Ordenes;

    @readonly
    entity Order_Details as projection on my.Order_Details;
}

@(path : '/GeneralService')
service generalService @(_requires : 'Scope1') {
    entity Productos     as projection on my.Productos;
    entity Ordenes       as projection on my.Ordenes;
    entity Order_Details as projection on my.Order_Details;

    entity resumen       as
        select from Order_Details {
            descuento,
            producto.nombre              as producto,
            producto.unidadesEnStock     as stock_actual,
            orden.informacionAdicionalID as order_resume
        }
        order by
            producto asc;

    type ingreso {
        precioPorUnidad       : Decimal;
        cantidad              : Integer;
        porcentajeDeDescuento : Decimal(7, 2);
        descuento             : Decimal(7, 2);
        total                 : Decimal(7, 2);
        totalFinal            : Decimal(7, 2);
    }

    action calcVenta(orderDetailID : Order_Details : ID) returns ingreso;
}
