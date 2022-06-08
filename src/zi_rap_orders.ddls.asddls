@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Orders View'

define root view entity ZI_RAP_ORDERS
  as select from zrap_orders as Orders

  composition [0..*] of ZI_RAP_ORDER_ITEMS  as _OrderItems
  association [0..1] to I_Currency as _Currency on $projection.currency_code = _Currency.Currency
{
  key mykey,
      note,
      @Semantics.amount.currencyCode: 'currency_code'
      total_price,
      currency_code,
      overall_status,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at,

      _Currency,
      _OrderItems
}
