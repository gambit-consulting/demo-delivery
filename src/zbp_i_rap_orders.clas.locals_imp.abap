CLASS lhc_Orders DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Orders RESULT result.

    METHODS get_features FOR FEATURES
      IMPORTING keys REQUEST requested_features FOR Orders RESULT result.

    METHODS earlynumbering_create FOR NUMBERING IMPORTING entities  FOR CREATE Orders.

    METHODS sendOrder FOR MODIFY
      IMPORTING keys FOR ACTION Orders~sendOrder RESULT result.

    METHODS cancelOrder FOR MODIFY
      IMPORTING keys FOR ACTION Orders~cancelOrder RESULT result.

    METHODS CalculateOrderDefaults FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Orders~CalculateOrderDefaults.

    METHODS earlynumbering_cba_Orderitems FOR NUMBERING
      IMPORTING entities FOR CREATE Orders\_Orderitems.

    METHODS recalctotalprice FOR MODIFY
      IMPORTING keys FOR ACTION Orders~recalctotalprice.

ENDCLASS.

CLASS lhc_Orders IMPLEMENTATION.


  METHOD get_features.

    READ ENTITIES OF zi_rap_orders IN LOCAL MODE ENTITY Orders FIELDS ( overall_status ) WITH CORRESPONDING #( keys ) RESULT DATA(lt_order_result).

    result = VALUE #( FOR ls_order IN lt_order_result
                       ( %tky                           = ls_order-%tky
                         %action-sendOrder = COND #( WHEN ls_order-overall_status = 'A' THEN if_abap_behv=>fc-o-enabled ELSE if_abap_behv=>fc-o-disabled )
                         %action-cancelOrder = COND #( WHEN ls_order-overall_status = 'A' THEN if_abap_behv=>fc-o-enabled ELSE if_abap_behv=>fc-o-disabled )
                      ) ).
  ENDMETHOD.

  METHOD cancelOrder.
    " Modify in local mode: BO-related updates that are not relevant for authorization checks
    MODIFY ENTITIES OF zi_rap_orders IN LOCAL MODE
           ENTITY Orders
              UPDATE FROM VALUE #( FOR key IN keys ( mykey = key-mykey
                                                     overall_status = 'C' " Abgeschickt
                                                     %control-overall_status = if_abap_behv=>mk-on ) )
           FAILED   failed
           REPORTED reported.

    " Read changed data for action result
    READ ENTITIES OF zi_rap_orders IN LOCAL MODE
         ENTITY Orders
         FROM VALUE #( FOR key IN keys (  mykey = key-mykey
                                          %control = VALUE #(
                                            total_price     = if_abap_behv=>mk-on
                                            currency_code   = if_abap_behv=>mk-on
                                            overall_status  = if_abap_behv=>mk-on
                                            note            = if_abap_behv=>mk-on
                                            created_by      = if_abap_behv=>mk-on
                                            created_at      = if_abap_behv=>mk-on
                                            last_changed_by = if_abap_behv=>mk-on
                                            last_changed_at = if_abap_behv=>mk-on
                                          ) ) )
         RESULT DATA(lt_order).

    result = VALUE #( FOR order IN lt_order ( mykey = order-mykey
                                                %param    = order
                                              ) ).
  ENDMETHOD.

  METHOD sendOrder.
    " Modify in local mode: BO-related updates that are not relevant for authorization checks
    MODIFY ENTITIES OF zi_rap_orders IN LOCAL MODE
           ENTITY Orders
              UPDATE FROM VALUE #( FOR key IN keys ( mykey = key-mykey
                                                     overall_status = 'B' " Abgeschickt
                                                     %control-overall_status = if_abap_behv=>mk-on ) )
           FAILED   failed
           REPORTED reported.

    " Read changed data for action result
    READ ENTITIES OF zi_rap_orders IN LOCAL MODE
         ENTITY Orders
         FROM VALUE #( FOR key IN keys (  mykey = key-mykey
                                          %control = VALUE #(
                                            total_price     = if_abap_behv=>mk-on
                                            currency_code   = if_abap_behv=>mk-on
                                            overall_status  = if_abap_behv=>mk-on
                                            note            = if_abap_behv=>mk-on
                                            created_by      = if_abap_behv=>mk-on
                                            created_at      = if_abap_behv=>mk-on
                                            last_changed_by = if_abap_behv=>mk-on
                                            last_changed_at = if_abap_behv=>mk-on
                                          ) ) )
         RESULT DATA(lt_order).

    result = VALUE #( FOR order IN lt_order ( mykey = order-mykey
                                                %param    = order
                                              ) ).
  ENDMETHOD.


  METHOD earlynumbering_create.
    SELECT SINGLE FROM zrap_orders FIELDS MAX( mykey ) INTO @DATA(lv_max_orderid).

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<ls_entity>).
      lv_max_orderid = lv_max_orderid + 1.
      INSERT VALUE #( %cid            = <ls_entity>-%cid
                      mykey  = lv_max_orderid ) INTO TABLE mapped-orders.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_global_authorizations.
    IF requested_authorizations-%create EQ if_abap_behv=>mk-on.

      "Check authorization via authorization object
*      AUTHORITY-CHECK OBJECT 'ZZ_AUTH_OBJ'
*            ID 'ZDUMMY' DUMMY
*            ID 'ACTVT' FIELD '01'.

*      IF sy-subrc = 0. " user is authorized
*        result-%create = if_abap_behv=>auth-allowed.

*      ELSE. " user is not authorized
*        result-%create = if_abap_behv=>auth-unauthorized.

      "Return custom message
*         APPEND VALUE #( %msg    = NEW zcx_error(
*                                        textid   = zcx_error=>not_authorized
*                                        severity = if_abap_behv_message=>severity-error )
*                          %global = if_abap_behv=>mk-on )
*                          %create = if_abap_behv=>mk-on )
*           TO reported-orders.
*       ENDIF.
      result-%create = if_abap_behv=>auth-allowed.
    ENDIF.

  ENDMETHOD.

  METHOD CalculateOrderDefaults.
    READ ENTITIES OF zi_rap_orders IN LOCAL MODE
    ENTITY Orders
    FIELDS ( overall_status currency_code )
    WITH CORRESPONDING #( keys )
    RESULT DATA(orders).
    MODIFY ENTITIES OF zi_rap_orders IN LOCAL MODE
    ENTITY Orders
    UPDATE SET FIELDS WITH VALUE #( FOR order IN orders (
        %key = order-%key
        overall_status = 'A'
        currency_code = 'EUR'
        %control = VALUE #(
            overall_status = if_abap_behv=>mk-on
            currency_code = if_abap_behv=>mk-on
    ) ) ) REPORTED DATA(modifyReported).
    reported = CORRESPONDING #( DEEP modifyreported ).

  ENDMETHOD.

  METHOD earlynumbering_cba_Orderitems.
    DATA: max_item_id TYPE posnr.

    READ ENTITIES OF zi_rap_orders IN LOCAL MODE
      ENTITY Orders BY \_OrderItems
        FROM CORRESPONDING #( entities )
        LINK DATA(items).

    " Loop over all unique TravelIDs
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<order_group>) GROUP BY <order_group>-mykey.

      " Get highest booking_id from bookings belonging to travel
      max_item_id = REDUCE #( INIT max = CONV posnr( '0' )
                                 FOR  item IN items USING KEY entity WHERE ( source-mykey  = <order_group>-mykey )
                                 NEXT max = COND posnr( WHEN item-target-pos > max
                                                                    THEN item-target-pos
                                                                    ELSE max )
                               ).
      " Get highest assigned booking_id from incoming entities
      max_item_id = REDUCE #( INIT max = max_item_id
                                 FOR  entity IN entities USING KEY entity WHERE ( mykey  = <order_group>-mykey )
                                 FOR  target IN entity-%target
                                 NEXT max = COND posnr( WHEN   target-pos > max
                                                                    THEN target-pos
                                                                    ELSE max )
                               ).

      " Loop over all entries in entities with the same TravelID
      LOOP AT entities ASSIGNING FIELD-SYMBOL(<order>) USING KEY entity WHERE mykey = <order_group>-mykey.

        " Assign new booking-ids if not already assigned
        LOOP AT <order>-%target ASSIGNING FIELD-SYMBOL(<item_wo_numbers>).
          APPEND CORRESPONDING #( <item_wo_numbers> ) TO mapped-items ASSIGNING FIELD-SYMBOL(<mapped_item>).
          IF <item_wo_numbers>-pos IS INITIAL.
            max_item_id += 10 .
            <mapped_item>-pos = max_item_id .
          ENDIF.
        ENDLOOP.

      ENDLOOP.

    ENDLOOP.
  ENDMETHOD.

  METHOD recalctotalprice.

    " Read all relevant travel instances.
    READ ENTITIES OF zi_rap_orders IN LOCAL MODE
         ENTITY Orders
            FIELDS ( total_price currency_code )
            WITH CORRESPONDING #( keys )
         RESULT DATA(orders).

    LOOP AT orders ASSIGNING FIELD-SYMBOL(<order>).
      " Read all associated bookings and add them to the total price.
      READ ENTITIES OF zi_rap_orders IN LOCAL MODE
        ENTITY Orders BY \_OrderItems ALL FIELDS
        WITH VALUE #( ( %tky = <order>-%tky ) )
        RESULT DATA(items).

      CLEAR <order>-total_price.
      LOOP AT items ASSIGNING FIELD-SYMBOL(<item>).
        <order>-total_price = <order>-total_price + ( <item>-quantity * <item>-price ).
      ENDLOOP.
    ENDLOOP.

    " write back the modified total_price of travels
    MODIFY ENTITIES OF zi_rap_orders IN LOCAL MODE
      ENTITY Orders
        UPDATE FIELDS ( total_price )
        WITH CORRESPONDING #( orders ).

  ENDMETHOD.

ENDCLASS.
