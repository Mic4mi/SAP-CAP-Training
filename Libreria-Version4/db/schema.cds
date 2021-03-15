using {
    cuid,
    managed
} from '@sap/cds/common';


namespace miLibrary;

entity Books : cuid {
    name    : String(111);
    author  : Association to Authors;
    comment : String(111);
}

entity Authors : cuid {
    name    : String(111);
    country : String(111);
    books   : Association to many Books
                  on books.author = $self;
}

entity Inventory : cuid, managed {
    book     : Association to Books;
    quantity : Integer;
    price    : Decimal(5, 2);
    comment  : String(111);
}
