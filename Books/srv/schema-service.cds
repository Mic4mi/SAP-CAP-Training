using {sap.capire.bookshop as my} from '../db/schema';

@(path: '/GeneralService')
service generalService @(_requires : 'Scope1') {
  entity Books   as projection on my.Books;
  entity Authors as projection on my.Authors;
  entity Genres as projection on my.Genres;
}

@(path: '/AuthService')
service AuthService @(requires:'Scope2') {
  entity Books as projection on my.Books;
  @readonly
  entity Authors as projection on my.Authors;
  entity Genres as projection on my.Genres;
}

@(path: '/AdminService')
service AdminService @(requires:'Scope1') {
  entity Books as projection on my.Books;
  @readonly
  entity Authors as projection on my.Authors;
  entity Genres as projection on my.Genres;
}

