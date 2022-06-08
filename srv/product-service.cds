using {gambit.demo.delivery as my} from '../db/schema';

service ProductService {

    @odata.draft.enabled
    entity Products as projection on my.Products;
}
