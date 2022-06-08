using {
    cuid,
    Currency,
    managed
} from '@sap/cds/common';

namespace gambit.demo.delivery;

entity Products : cuid, managed {
    category : String(40);
    name     : String(40);
    price    : Decimal;
    currency : Currency;
    rating   : Decimal(4, 2) @readonly;
}

entity Orders : managed {
    key id         : Integer @Core.Computed : true;
        note       : String(120);
        totalPrice : Decimal @Core.Computed : true;
        currency   : Currency;
        status     : String(1);
        to_Items   : Composition of many Items
                         on to_Items.to_Orders = $self;
}

entity Items {
    key id                 : Integer               @Core.Computed : true;
    key to_Orders          : Association to one Orders @Core.Computed : true;
        quantity           : Integer;
        note               : String(120);
        virtual totalPrice : Decimal;
        product            : Association to one Products;
}
