class ZCL_I_D_CREATE_BOOKING definition
  public
  inheriting from /BOBF/CL_LIB_D_SUPERCL_SIMPLE
  final
  create public .

public section.

  methods /BOBF/IF_FRW_DETERMINATION~EXECUTE
    redefinition .
protected section.
private section.
ENDCLASS.



CLASS ZCL_I_D_CREATE_BOOKING IMPLEMENTATION.


  METHOD /bobf/if_frw_determination~execute.
    DATA(bookings) = VALUE ztifapp_bookingtp3( ).
    io_read->retrieve(
      EXPORTING
        iv_node = zif_i_fapp_flightstp3_c=>sc_node-zi_fapp_bookingtp
        it_key = it_key
      IMPORTING
        et_Data = bookings
        et_failed_key = DATA(failed_keys)
    ).

    DATA(flights) = VALUE ztifapp_flightstp3( ).
    io_read->retrieve_by_association(
      EXPORTING
        iv_node = zif_i_fapp_flightstp3_c=>sc_node-zi_fapp_bookingtp
        iv_association = zif_i_fapp_flightstp3_c=>sc_association-zi_fapp_bookingtp-to_root
        it_key = it_key
        iv_fill_data = abap_true
      IMPORTING
        et_data = flights
        et_failed_key = failed_keys
        et_target_key = DATA(flight_keys)
    ).

    DATA(bookings_bi) = VALUE ztifapp_bookingtp3( ).
    io_read->retrieve_by_association(
      EXPORTING
        iv_node = zif_i_fapp_flightstp3_c=>sc_node-zi_fapp_flightstp
        iv_association = zif_i_fapp_flightstp3_c=>sc_association-zi_fapp_flightstp-_bookings
        it_key = flight_keys
        iv_fill_data = abap_true
        iv_before_image = abap_false
      IMPORTING
        et_data = bookings_bi
    ).

    CALL FUNCTION 'NUMBER_RANGE_ENQUEUE'
      EXPORTING
        object           = 'ZFAPP_BOOK'
      EXCEPTIONS
        foreign_lock     = 1
        object_not_found = 2
        system_failure   = 3
        OTHERS           = 4.

    IF sy-subrc IS NOT INITIAL.
      et_failed_key = it_key.
      RETURN.
    ENDIF.

    DATA(booking_id) = VALUE string( ).
    DATA: rc TYPE inri-returncode.

    LOOP AT bookings REFERENCE INTO DATA(booking).
      CLEAR booking->id.
      READ TABLE flights REFERENCE INTO DATA(flight) WITH TABLE KEY key_sorted COMPONENTS key = booking->root_key.
      IF sy-subrc IS NOT INITIAL.
        APPEND VALUE #( key = booking->key ) TO et_failed_Key.
        CONTINUE.
      ENDIF.
      DATA(lv_skip) = abap_false.
      WHILE lv_skip = abap_false.
        lv_skip = abap_true.
        CALL FUNCTION 'NUMBER_GET_NEXT'
          EXPORTING
            nr_range_nr             = '1'   " Range
            object                  = 'ZFAPP_BOOK'       " Object (SNRO)
          IMPORTING
            number                  = booking_id       " generated number
            returncode              = rc
          EXCEPTIONS
            interval_not_found      = 1
            number_range_not_intern = 2
            object_not_found        = 3
            quantity_is_0           = 4
            quantity_is_not_1       = 5
            interval_overflow       = 6
            buffer_overflow         = 7
            OTHERS                  = 8.
        IF sy-subrc IS NOT INITIAL OR rc IS NOT INITIAL.
          APPEND VALUE #( key = booking->key ) TO et_failed_Key.
          CONTINUE.
        ENDIF.
        IF line_exists( bookings_bi[ id = booking_id carrierid = flight->carrierid connectionid = flight->connectionid flightdate = flight->flightdate ] ).
          lv_skip = abap_false.
        ENDIF.
      ENDWHILE.

      booking->id = booking_id.
      booking->carrierid = flight->carrierid.
      booking->connectionid = flight->connectionid.
      booking->flightdate = flight->flightdate.
      booking->orderdate = sy-datum.
      booking->cancelled = abap_false.

      io_modify->update(
        EXPORTING
          iv_node = zif_i_fapp_flightstp3_c=>sc_node-zi_fapp_bookingtp
          iv_key = booking->key
          is_data = booking
      ).
    ENDLOOP.

    CALL FUNCTION 'NUMBER_RANGE_DEQUEUE'
      EXPORTING
        object           = 'ZFAPP_BOOK'
      EXCEPTIONS
        object_not_found = 1
        OTHERS           = 2.
  ENDMETHOD.
ENDCLASS.
