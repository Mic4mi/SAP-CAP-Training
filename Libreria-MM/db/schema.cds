using {cuid} from '@sap/cds/common';


namespace miLibrary;

entity Books : cuid {
    name     : localized String(111);
    authors  : Association to many Books_Authors
                   on authors.books = $self;
    editions : Composition of Editions;
}

entity Authors : cuid {
    name    : localized String(111);
    country : localized String(111);
    books   : Association to many Books_Authors
                  on books.authors = $self;
}


@cds.autoexpose entity Editions : cuid {
    year : Integer;
    name : String(50);
}

@cds.autoexpose entity Books_Authors {
    key books   : Association to Books;
    key authors : Association to Authors;
}
