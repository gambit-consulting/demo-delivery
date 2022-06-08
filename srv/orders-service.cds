using {gambit.demo.delivery as my} from '../db/schema';

service OrdersService @(path : 'public') {

    @odata.draft.enabled
    entity Orders   as projection on my.Orders;

    entity Items    as projection on my.Items;

    @readonly
    entity Products as
        select from my.Products {
            key ID as id,
                category,
                name,
                price,
                currency,
                rating
        };


}
