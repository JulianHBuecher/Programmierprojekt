CLASS zcl_i_a_change_currency DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cl_lib_a_supercl_simple
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS /bobf/if_frw_action~execute
        REDEFINITION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_i_a_change_currency IMPLEMENTATION.


  METHOD /bobf/if_frw_action~execute.
    DATA bookings TYPE ztifapp_bookingtp3.
    DATA message TYPE REF TO zcm_fapp_booking.
    DATA co_amount TYPE s_f_cur_pr.
    DATA co_oldcur TYPE s_curr.

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

      co_oldcur = booking->amountcurrency.

      IF booking->amountcurrency <> 'EUR' AND booking->amountcurrency <> 'USD'.
        " Create error message
        message = NEW zcm_fapp_booking(
          textid   = zcm_fapp_booking=>co_change_cu_unsuccessful
          severity = zcm_fapp_booking=>co_severity_error
        ).
        et_failed_key = VALUE #( BASE et_failed_key ( key = booking->key ) ).
        eo_message->add_cm( message ).
        CONTINUE.
      ELSEIF booking->amountcurrency = 'USD'.
        " Change to EUR
        booking->amountcurrency  = 'EUR'.

      ELSEIF booking->amountcurrency = 'EUR'.
        " Change to USD
        booking->amountcurrency = 'USD'.
      ENDIF.

      CALL FUNCTION 'CONVERT_AMOUNT_TO_CURRENCY'
        EXPORTING
          date             = sy-datum
          foreign_currency = co_oldcur
          foreign_amount   = booking->amount
          local_currency   = booking->amountcurrency
        IMPORTING
          local_amount     = co_amount.

      booking->amount = co_amount.

      " Create success message
      message = NEW zcm_fapp_booking(
        textid     = zcm_fapp_booking=>co_change_cu_successful
        severity   = zcm_fapp_booking=>co_severity_success
        i_currency = booking->amountcurrency
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
