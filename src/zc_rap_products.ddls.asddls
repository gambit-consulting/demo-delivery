@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View for Products'
@Search.searchable: true
@UI: {
 headerInfo: {
    typeName: 'Produkt',
    typeNamePlural: 'Produkte',
    title: {
        type: #STANDARD,
        value: 'ProductID'
    }
  }
}
define root view entity ZC_RAP_PRODUCTS
  provider contract transactional_query
  as projection on ZI_RAP_PRODUCTS
{
      @UI.facet: [
              {
                id:'generalProductInfo' ,
                type: #COLLECTION ,
                label: 'Produktdetails' ,
                position: 10
              },
              {
                type: #IDENTIFICATION_REFERENCE ,
                label : 'Produktdetails',
                parentId: 'generalProductInfo',
                id: 'generalProductInfoSection' ,
                position: 10
              }
            ]

      @UI.hidden: true
  key id              as ProductID,
      @UI: {
           lineItem:       [ { position: 10, importance: #HIGH } ],
           identification: [ { position: 10 } ] }
      @Search.defaultSearchElement: true
      @EndUserText.label: 'Kategorie'
      category        as Category,
      @UI: {
           lineItem:       [ { position: 20, importance: #HIGH } ],
           identification: [ { position: 20 } ] }
      @Search.defaultSearchElement: true
      @EndUserText.label: 'Produkt'
      name            as Name,
      @UI: {
           lineItem:       [ { position: 30, importance: #MEDIUM } ],
           identification: [ { position: 30 } ] }
      @Semantics.amount.currencyCode: 'Currency'
      @EndUserText.label: 'Preis'
      price           as Price,
      @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
      currency_code   as Currency,
      @UI.hidden: true
      last_changed_at as LastChangedAt
}
