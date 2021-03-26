using {northwindApp as my} from '../db/schema';

service api {
    entity Productos     as projection on my.Productos;
    entity Ordenes       as projection on my.Ordenes;
    entity Order_Details as projection on my.Order_Details;
}
