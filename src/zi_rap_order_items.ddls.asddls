@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Order Items View'
define view entity ZI_RAP_ORDER_ITEMS
  as select from zrap_order_items as order_items

  association [1..1] to ZI_RAP_PRODUCTS      as _Product on $projection.product = _Product.id
  association        to parent ZI_RAP_ORDERS as _Order   on $projection.mykey = _Order.mykey

{
  key mykey,
  key pos,
      product,
      quantity,
      note,
      @Semantics.amount.currencyCode: 'currency_code'
      _Product.price as price,
      _Product.currency_code as currency_code,

      _Product,
      _Order
}
