@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Consumption View for Order Items'
@Search.searchable: true
@UI: {
  headerInfo: { typeName: 'Position',
                typeNamePlural: 'Positionen',
                title: { type: #STANDARD, value: 'Item' }
  }
}
define view entity ZC_RAP_ORDER_ITEMS
  as projection on ZI_RAP_ORDER_ITEMS
{

          @UI.facet: [
              {
                id:'generalItemInfo' ,
                type: #COLLECTION ,
                label: 'Bestellposition' ,
                position: 10
              },
              {
                type: #IDENTIFICATION_REFERENCE ,
                label : 'Bestellposition',
                parentId: 'generalItemInfo',
                id: 'generalItemInfoSection',
                position: 10
              }
          ]
          @Search.defaultSearchElement: true
          @UI.hidden: true
  key     mykey             as OrderID,


          @UI: {
              lineItem:       [ { position: 10, importance: #HIGH } ],
              identification: [ { position: 10 } ] }
          @EndUserText.label: 'Position'
  key     pos               as Item,


          @UI: {

              identification: [ { position: 20 } ] }
          @EndUserText.label: 'Produkt'
          @Consumption.valueHelpDefinition: [{association: '_Product'}]
          product           as Product,


          @UI: {
              lineItem:       [ { position: 30, importance: #HIGH } ],
              identification: [ { position: 30 } ] }
          @EndUserText.label: 'Produktbezeichnung'
          _Product.name     as ProductText,

          @UI: {
                lineItem:       [ { position: 40, importance: #HIGH } ],
                identification: [ { position: 40 } ] }
          @EndUserText.label: 'Kategorie'
          _Product.category as ProductCategory,

          @UI: {
              lineItem:       [ { position: 50, importance: #HIGH } ],
              identification: [ { position: 50 } ] }
          @EndUserText.label: 'Preis pro Einheit'
          @Semantics.amount.currencyCode: 'CurrencyCode'
          _Product.price             as ProductPrice,


          @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
          _Product.currency_code     as CurrencyCode,

          @UI: {
              lineItem:       [ { position: 60, importance: #HIGH } ],
              identification: [ { position: 60 } ] }
          @EndUserText.label: 'Menge'
          quantity          as Quantity,

          @UI: {
              lineItem:       [ { position: 80, importance: #HIGH } ],
              identification: [ { position: 80 } ] }
          @EndUserText.label: 'Anmerkung'
          note              as Note,

          @UI: {
            lineItem:       [ { position: 70, importance: #HIGH } ],
            identification: [ { position: 70 } ] }
          @EndUserText.label: 'Gesamtpreis'
          @ObjectModel.virtualElement:true
          @ObjectModel.virtualElementCalculatedBy:    'ABAP:ZCL_RAP_CALC_POS_TOTAL_PRICE'
          @Semantics.amount.currencyCode: 'CurrencyCode'
  virtual TotalPrice : abap.curr( 10, 2 ),

          /* Associations */
          _Order   : redirected to parent ZC_RAP_ORDERS,
          _Product : redirected to ZC_RAP_PRODUCTS
}
