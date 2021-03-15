using {misAutos as my} from '../db/schema';

service api {

    entity Marcas    as
        select from my.Marcas {
            *
        };

    entity Modelos   as
        select from my.Modelos {
            *,
            marca.name as marca_name
        };

}
