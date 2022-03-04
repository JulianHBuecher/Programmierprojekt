CLASS zcm_fapp_booking DEFINITION
  PUBLIC
  INHERITING FROM /bobf/cm_frw
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CONSTANTS:
      BEGIN OF co_cancel_booking,
        msgid TYPE symsgid VALUE 'ZFAPPBOOKING',
        msgno TYPE symsgno VALUE '000',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_cancel_booking.
    CONSTANTS:
      BEGIN OF co_cancel_failed_booking,
        msgid TYPE symsgid VALUE 'ZFAPPBOOKING',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_cancel_failed_booking.
    CONSTANTS:
      BEGIN OF co_change_cu_successful,
        msgid TYPE symsgid VALUE 'ZFAPPBOOKING',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'CURRENCY',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_change_cu_successful.
    CONSTANTS:
      BEGIN OF co_change_cu_unsuccessful,
        msgid TYPE symsgid VALUE 'ZFAPPBOOKING',
        msgno TYPE symsgno VALUE '003',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_change_cu_unsuccessful.
    CONSTANTS:
      BEGIN OF co_non_negative_value,
        msgid TYPE symsgid VALUE 'ZFAPPBOOKING',
        msgno TYPE symsgno VALUE '004',
        attr1 TYPE scx_attrname VALUE 'attr1',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_non_negative_value.
         CONSTANTS:
      BEGIN OF co_non_existing_currency,
        msgid TYPE symsgid VALUE 'ZFAPPBOOKING',
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE 'CURRENCY',
        attr2 TYPE scx_attrname VALUE 'attr2',
        attr3 TYPE scx_attrname VALUE 'attr3',
        attr4 TYPE scx_attrname VALUE 'attr4',
      END OF co_non_existing_currency.

    DATA currency TYPE s_currcode.

    METHODS constructor
      IMPORTING
        !textid                  LIKE if_t100_message=>t100key OPTIONAL
        !previous                LIKE previous OPTIONAL
        !severity                TYPE ty_message_severity OPTIONAL
        !symptom                 TYPE ty_message_symptom OPTIONAL
        !lifetime                TYPE ty_message_lifetime DEFAULT co_lifetime_transition
        !ms_origin_location      TYPE /bobf/s_frw_location OPTIONAL
        !mt_environment_location TYPE /bobf/t_frw_location OPTIONAL
        !mv_act_key              TYPE /bobf/act_key OPTIONAL
        !mv_assoc_key            TYPE /bobf/obm_assoc_key OPTIONAL
        !mv_bopf_location        TYPE /bobf/conf_key OPTIONAL
        !mv_det_key              TYPE /bobf/det_key OPTIONAL
        !mv_query_key            TYPE /bobf/obm_query_key OPTIONAL
        !mv_val_key              TYPE /bobf/val_key OPTIONAL
        i_currency               TYPE s_currcode OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcm_fapp_booking IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous                = previous
        severity                = severity
        symptom                 = symptom
        lifetime                = lifetime
        ms_origin_location      = ms_origin_location
        mt_environment_location = mt_environment_location
        mv_act_key              = mv_act_key
        mv_assoc_key            = mv_assoc_key
        mv_bopf_location        = mv_bopf_location
        mv_det_key              = mv_det_key
        mv_query_key            = mv_query_key
        mv_val_key              = mv_val_key.
    CLEAR me->textid.
    currency = i_currency.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
