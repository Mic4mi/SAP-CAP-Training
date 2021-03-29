using {northwindApp as my} from '../db/schema';

@(path : '/AuthService')
service AuthService @(requires : 'authenticated-user') {
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

@(path : '/GeneralService')
service generalService @(_requires : 'Scope1') {
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
