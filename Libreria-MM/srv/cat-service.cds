using {miLibrary as my} from '../db/schema';

service api {

    entity Books         as
        select from my.Books {
            *
        };

    entity Authors       as
        select from my.Authors {
            *
        };

    entity Editions      as
        select from my.Editions {
            *
        };

    entity Books_Authors as
        select from my.Books_Authors {
            *
        };
}
