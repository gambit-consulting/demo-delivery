@EndUserText.label: 'Product View for Orders'
@AccessControl.authorizationCheck: #CHECK
@Search.searchable: true
@UI: {
 headerInfo: {
    typeName: 'Bestellung',
    typeNamePlural: 'Bestellungen',
    title: {
        type: #STANDARD,
        value: 'OrderID'
    }
  }
}

define root view entity ZC_RAP_ORDERS
  provider contract transactional_query
  as projection on ZI_RAP_ORDERS
{
      @UI.facet: [
        {
          id:'generalInfo' ,
          type: #COLLECTION ,
          label: 'Bestelldetails' ,
          position: 10
        },
        {
          type: #IDENTIFICATION_REFERENCE ,
          label : 'Bestelldetails',
          parentId: 'generalInfo',
          id: 'generalInfoSection' ,
          position: 10
        },
        {
          id: 'OrderItems',
          purpose: #STANDARD,
          type: #LINEITEM_REFERENCE,
          label: 'Bestellpositionen',
          position: 20,
          targetElement: '_OrderItems'
        }
      ]


      @UI: {
          lineItem:       [ { position: 10, importance: #HIGH } ],
          identification: [ { position: 10 } ] }
      @Search.defaultSearchElement: true
      @EndUserText.label: 'Bestellnr.'
  key mykey           as OrderID,

      @UI: {
         lineItem:       [ { position: 20, importance: #MEDIUM } ],
         identification: [ { position: 20 } ] }
      @Semantics.amount.currencyCode: 'Currency'
      @EndUserText.label: 'Preis'
      total_price     as Price,

      @Consumption.valueHelpDefinition: [{entity: {name: 'I_Currency', element: 'Currency' }}]
      currency_code   as Currency,

      @UI: {
      lineItem:       [ { position: 30, importance: #HIGH },
                        { type: #FOR_ACTION, dataAction: 'sendOrder', label: 'Abschicken' },
                        { type: #FOR_ACTION, dataAction: 'cancelOrder', label: 'Stornieren' } ],
      identification: [ { position: 30 } ]  }
      @EndUserText.label: 'Status'
      overall_status  as Status,

      @UI: {
         lineItem:       [ { position: 40, importance: #MEDIUM } ],
         identification: [ { position: 40 } ] }
      @EndUserText.label: 'Besteller'
      created_by      as Customer,

      @UI: {
      lineItem:       [ { position: 50, importance: #HIGH } ],
      identification: [ { position: 50 } ] }
      @EndUserText.label: 'Bemerkung'
      @UI.fieldGroup: [{ qualifier: 'idIdentification' , position: 10 }]
      note            as Note,

      @UI.hidden: true
      last_changed_at as LastChangedAt,

      @UI: {
      lineItem:       [ { position: 60, importance: #HIGH } ],
      identification: [ { position: 60 } ] }
      @EndUserText.label: 'Bestelldatum'
      created_at      as Bestelldatum,

      _OrderItems : redirected to composition child ZC_RAP_ORDER_ITEMS
}
