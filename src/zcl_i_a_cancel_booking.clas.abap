class ZCL_I_A_CANCEL_BOOKING definition
  public
  inheriting from /BOBF/CL_LIB_A_SUPERCL_SIMPLE
  final
  create public .

public section.

  methods /BOBF/IF_FRW_ACTION~EXECUTE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_I_A_CANCEL_BOOKING IMPLEMENTATION.


METHOD /bobf/if_frw_action~execute.
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
      IF booking->cancelled = 'X'.
      " Already cancelled
      " Create error message
        message = NEW zcm_fapp_booking(
          textid   = zcm_fapp_booking=>co_cancel_failed_booking
          severity = zcm_fapp_booking=>co_severity_error
        ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = booking->key ) ).
        eo_message->add_cm( message ).
        CONTINUE.
      ELSE.
      " Not cancelled
        booking->cancelled = 'X'.
      ENDIF.

        " Create success message
        message = NEW zcm_fapp_booking(
          textid   = zcm_fapp_booking=>co_cancel_booking
          severity = zcm_fapp_booking=>co_severity_success
        ).

        eo_message->add_cm( message ).

      " Write data back
      io_modify->update(
        EXPORTING
          iv_node = is_ctx-node_key
          iv_key  = booking->key
          is_data = booking ).
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
