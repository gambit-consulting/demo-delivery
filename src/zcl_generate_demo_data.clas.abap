CLASS zcl_generate_demo_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_generate_demo_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lt_products TYPE TABLE OF zrap_products.

    DELETE FROM zrap_orders.
    DELETE FROM zrap_products.
    DELETE FROM zrap_order_items.

    CONVERT DATE sy-datum TIME sy-uzeit INTO TIME STAMP DATA(time_stamp) TIME ZONE 'UTC'.

    APPEND INITIAL LINE TO lt_products ASSIGNING FIELD-SYMBOL(<ls_product>).
    <ls_product>-id       = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_c36_by_version( version = 4 ).
    <ls_product>-category       = 'Pizza'.
    <ls_product>-name           = 'Margherita'.
    <ls_product>-price          = '6.5'.
    <ls_product>-currency_code  = 'EUR'.
    <ls_product>-created_at  = time_stamp.
    <ls_product>-created_by  = sy-uname.
    <ls_product>-last_changed_at  = time_stamp.
    <ls_product>-last_changed_by  = sy-uname.

    APPEND INITIAL LINE TO lt_products ASSIGNING <ls_product>.
    <ls_product>-id       = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_c36_by_version( version = 4 ).
    <ls_product>-category       = 'Pizza'.
    <ls_product>-name           = 'Salami'.
    <ls_product>-price          = '7.5'.
    <ls_product>-currency_code  ='EUR'.
    <ls_product>-created_at  = time_stamp.
    <ls_product>-created_by  = sy-uname.
    <ls_product>-last_changed_at  = time_stamp.
    <ls_product>-last_changed_by  = sy-uname.

    APPEND INITIAL LINE TO lt_products ASSIGNING <ls_product>.
    <ls_product>-id       = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_c36_by_version( version = 4 ).
    <ls_product>-category       = 'Pizza'.
    <ls_product>-name           = 'Tonno'.
    <ls_product>-price          = '8.5'.
    <ls_product>-currency_code  ='EUR'.
    <ls_product>-created_at  = time_stamp.
    <ls_product>-created_by  = sy-uname.
    <ls_product>-last_changed_at  = time_stamp.
    <ls_product>-last_changed_by  = sy-uname.

    APPEND INITIAL LINE TO lt_products ASSIGNING <ls_product>.
    <ls_product>-id       = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_c36_by_version( version = 4 ).
    <ls_product>-category       = 'Pasta'.
    <ls_product>-name           = 'Aglio e Olio'.
    <ls_product>-price          = '5.5'.
    <ls_product>-currency_code  ='EUR'.
    <ls_product>-created_at  = time_stamp.
    <ls_product>-created_by  = sy-uname.
    <ls_product>-last_changed_at  = time_stamp.
    <ls_product>-last_changed_by  = sy-uname.

    APPEND INITIAL LINE TO lt_products ASSIGNING <ls_product>.
    <ls_product>-id       = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_c36_by_version( version = 4 ).
    <ls_product>-category       = 'Pasta'.
    <ls_product>-name           = 'Carbonara'.
    <ls_product>-price          = '8.0'.
    <ls_product>-currency_code  ='EUR'.
    <ls_product>-created_at  = time_stamp.
    <ls_product>-created_by  = sy-uname.
    <ls_product>-last_changed_at  = time_stamp.
    <ls_product>-last_changed_by  = sy-uname.

    APPEND INITIAL LINE TO lt_products ASSIGNING <ls_product>.
    <ls_product>-id       = cl_system_uuid=>if_system_uuid_rfc4122_static~create_uuid_c36_by_version( version = 4 ).
    <ls_product>-category       = 'Dessert'.
    <ls_product>-name           = 'Tiramisu'.
    <ls_product>-price          = '6.5'.
    <ls_product>-currency_code  ='EUR'.
    <ls_product>-created_at  = time_stamp.
    <ls_product>-created_by  = sy-uname.
    <ls_product>-last_changed_at  = time_stamp.
    <ls_product>-last_changed_by  = sy-uname.

    INSERT zrap_products FROM TABLE lt_products.

    COMMIT WORK.

    out->write( 'Data generated' ).
  ENDMETHOD.
ENDCLASS.
