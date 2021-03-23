using {axios as my} from '../db/schema';

service api {
    entity Tecnologias as projection on my.Tecnologias;
}
