CLASS lhc_items DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS calculateTotalPrice FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Items~calculateTotalPrice.

ENDCLASS.

CLASS lhc_items IMPLEMENTATION.

  METHOD calculateTotalPrice.
    MODIFY ENTITIES OF zi_rap_orders IN LOCAL MODE
       ENTITY Orders
         EXECUTE recalctotalprice
         FROM CORRESPONDING #( keys ).
  ENDMETHOD.

ENDCLASS.
