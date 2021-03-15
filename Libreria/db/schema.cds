using {cuid} from '@sap/cds/common';


namespace miLibrary;

entity Books : cuid {
    name     : localized String(111);
    author   : Association to Authors;
    editions : Composition of Editions;
}

entity Authors : cuid {
    name    : localized String(111);
    country : localized String(111);
    books   : Association to many Books
                  on books.author = $self;
}
@cds.autoexpose
entity Editions : cuid {
    year : Integer;
    name : String(50);
}
