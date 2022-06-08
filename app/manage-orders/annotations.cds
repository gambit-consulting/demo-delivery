using OrdersService as service from '../../srv/orders-service';

annotate service.Orders with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : id,
            Label : 'ID',
        },
        {
            $Type : 'UI.DataField',
            Value : totalPrice,
            Label : '{i18n>TotalPrice}',
        },
        {
            $Type : 'UI.DataField',
            Value : status,
            Label : '{i18n>Status}',
        },
        {
            $Type : 'UI.DataField',
            Value : note,
            Label : '{i18n>Note}',
        },
        {
            $Type : 'UI.DataField',
            Value : createdBy,
        },
        {
            $Type : 'UI.DataField',
            Value : createdAt,
        },
    ]
);
annotate service.Orders with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>OrderDetails}',
            ID : 'i18nBestelldetails',
            Target : '@UI.FieldGroup#i18nBestelldetails',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>OrderItems}',
            ID : 'Bestellpositionen',
            Target : 'to_Items/@UI.LineItem#Bestellpositionen',
        },
    ],
    UI.FieldGroup #i18nBestelldetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : id,
                Label : 'ID',
            },{
                $Type : 'UI.DataField',
                Value : totalPrice,
                Label : '{i18n>TotalPrice}',
            },{
                $Type : 'UI.DataField',
                Value : status,
                Label : '{i18n>Status}',
            },{
                $Type : 'UI.DataField',
                Value : note,
                Label : '{i18n>Note}',
            },{
                $Type : 'UI.DataField',
                Value : createdBy,
            },{
                $Type : 'UI.DataField',
                Value : createdAt,
            },],
    }
);
annotate service.Orders with @(
    UI.HeaderInfo : {
        TypeName : '{i18n>Order}',
        TypeNamePlural : '{i18n>Orders}',
        Title : {
            $Type : 'UI.DataField',
            Value : id,
        },
    }
);
annotate service.Items with @(
    UI.LineItem #Bestellpositionen : [
        {
            $Type : 'UI.DataField',
            Value : id,
            Label : 'ID',
        },{
            $Type : 'UI.DataField',
            Value : product.category,
            Label : '{i18n>Category}',
        },{
            $Type : 'UI.DataField',
            Value : product.name,
            Label : '{i18n>Name}',
        },{
            $Type : 'UI.DataField',
            Value : product.price,
            Label : '{i18n>Price}',
        },{
            $Type : 'UI.DataField',
            Value : quantity,
            Label : '{i18n>Quantity}',
        },{
            $Type : 'UI.DataField',
            Value : note,
            Label : '{i18n>Note}',
        },]
);
annotate service.Items with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : '{i18n>OrderDetails}',
            ID : 'Produktdetails',
            Target : '@UI.FieldGroup#Produktdetails',
        },
    ],
    UI.FieldGroup #Produktdetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : id,
                Label : 'ID',
            },{
                $Type : 'UI.DataField',
                Value : note,
                Label : '{i18n>Note}',
            },{
                $Type : 'UI.DataField',
                Value : product.name,
                Label : '{i18n>Name}',
            },{
                $Type : 'UI.DataField',
                Value : product.price,
                Label : '{i18n>Price}',
            },{
                $Type : 'UI.DataField',
                Value : product.category,
                Label : '{i18n>Category}',
            },],
    }
);
annotate service.Orders with {
    totalPrice @Measures.ISOCurrency : currency_code
};
annotate service.Items with @(
    UI.HeaderInfo : {
        TypeName : '{i18n>Item}',
        TypeNamePlural : '{i18n>Items}',
    }
);
