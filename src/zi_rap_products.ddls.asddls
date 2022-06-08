@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Product View'
define root view entity ZI_RAP_PRODUCTS
  as select from zrap_products as Products
  association [0..1] to I_Currency as _Currency on $projection.currency_code = _Currency.Currency
{
  key id,
      category,
      name,
      @Semantics.amount.currencyCode: 'currency_code'
      price,
      currency_code,
      @Semantics.user.createdBy: true
      created_by,
      @Semantics.systemDateTime.createdAt: true
      created_at,
      @Semantics.user.lastChangedBy: true
      last_changed_by,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at,

      _Currency
}
