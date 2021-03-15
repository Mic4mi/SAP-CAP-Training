using {miLibrary as my} from '../db/schema';

service api {

    entity Books     as
        select from my.Books {
            *,
            author.name as author_name
        };

    entity Authors   as
        select from my.Authors {
            *
        };

    entity Inventory as
        select from my.Inventory {
            *,
            book.name,
            book.author.ID,
            book.author.name as author_name,
            book.author.country
        };

    action modInven(book : Books : ID, amount : Integer) returns String;
    action insertOrder(book : array of my.Inventory) returns String;

}
