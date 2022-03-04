CLASS zcl_i_v_non_negative_values DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_v_supercl_simple
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /bobf/if_frw_validation~execute
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_i_v_non_negative_values IMPLEMENTATION.


  METHOD /bobf/if_frw_validation~execute.
    DATA bookings TYPE ztifapp_bookingtp3.
    DATA message TYPE REF TO zcm_fapp_booking.

    " Read data
    io_read->retrieve(
      EXPORTING
        iv_node       = is_ctx-node_key
        it_key        = it_key
      IMPORTING
        eo_message    = eo_message
        et_data       = bookings
        et_failed_key = et_failed_key ).

    " Create message container
    IF eo_message IS NOT BOUND.
      eo_message = /bobf/cl_frw_factory=>get_message( ).
    ENDIF.

    " Loop over data
    LOOP AT bookings REFERENCE INTO DATA(booking).
      IF booking->amount < 0 OR booking->luggageweight < 0.
        " Create error message
        message = NEW zcm_fapp_booking(
          textid   = zcm_fapp_booking=>co_non_negative_value
          severity = zcm_fapp_booking=>co_severity_error
        ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = booking->key ) ).

        eo_message->add_cm( message ).
        CONTINUE.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
