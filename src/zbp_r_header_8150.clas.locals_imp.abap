CLASS lhc_Z_R_HEADER_8150 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    CONSTANTS:
      accept TYPE int2 VALUE '1',
      open   TYPE int2 VALUE '2',
      reject TYPE int2 VALUE '3'.


    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Header RESULT result.

    METHODS setStatusToOpen FOR DETERMINE ON MODIFY
      IMPORTING keys FOR Header~setStatusToOpen.

    METHODS setDate FOR DETERMINE ON SAVE
      IMPORTING keys FOR Header~setDate.
    METHODS accepted FOR MODIFY
      IMPORTING keys FOR ACTION Header~accepted RESULT result.

    METHODS rejected FOR MODIFY
      IMPORTING keys FOR ACTION Header~rejected RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Header RESULT result.
    METHODS setimageurl FOR DETERMINE ON SAVE
      IMPORTING keys FOR header~setimageurl.

ENDCLASS.

CLASS lhc_Z_R_HEADER_8150 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD setStatusToOpen.

    READ ENTITIES OF z_r_header_8150 IN LOCAL MODE
      ENTITY Header
      FIELDS ( OrderStatus )
      WITH CORRESPONDING #( keys )
      RESULT DATA(status).

    DELETE status WHERE OrderStatus IS NOT INITIAL.

    CHECK status IS NOT INITIAL.


    MODIFY ENTITIES OF z_r_header_8150 IN LOCAL MODE
    ENTITY Header
    UPDATE FIELDS ( OrderStatus )
    WITH VALUE #( FOR statu IN status INDEX INTO i  ( %tky = statu-%tky
                                                     OrderStatus = open ) ).
  ENDMETHOD.

  METHOD setDate.

    READ ENTITIES OF z_r_header_8150 IN LOCAL MODE
        ENTITY Header
        FIELDS ( Creaton DeliveryDate )
        WITH CORRESPONDING #( keys )
        RESULT DATA(dates).

    DELETE dates WHERE creaton IS NOT INITIAL.


    CHECK dates IS NOT INITIAL.

    MODIFY ENTITIES OF z_r_header_8150 IN LOCAL MODE
    ENTITY Header
    UPDATE FIELDS ( Creaton DeliveryDate )
    WITH VALUE #( FOR date IN dates INDEX INTO i ( %tky = date-%tky
                                                   Creaton = sy-datlo
                                                   DeliveryDate = sy-datlo + 30 ) ).
  ENDMETHOD.

  METHOD accepted.

    MODIFY ENTITIES OF z_r_header_8150 IN LOCAL MODE
    ENTITY Header
    UPDATE FIELDS ( OrderStatus )
    WITH VALUE #( FOR key IN keys ( %tky = key-%tky
                                    OrderStatus = accept ) ).

    READ ENTITIES OF z_r_header_8150 IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(status).

    result = value #(  for header in status ( %tky = header-%tky
                                              %param = header ) ).

  ENDMETHOD.

  METHOD rejected.

  MODIFY ENTITIES OF z_r_header_8150 IN LOCAL MODE
    ENTITY Header
    UPDATE FIELDS ( OrderStatus )
    WITH VALUE #( FOR key IN keys ( %tky = key-%tky
                                    OrderStatus = reject ) ).

    READ ENTITIES OF z_r_header_8150 IN LOCAL MODE
    ENTITY Header
    ALL FIELDS WITH CORRESPONDING #( keys )
    RESULT DATA(status).

    result = value #(  for header in status ( %tky = header-%tky
                                              %param = header ) ).
  ENDMETHOD.

  METHOD get_instance_features.

  READ ENTITIES OF z_r_header_8150 IN LOCAL MODE
          ENTITY Header
          FIELDS ( OrderStatus )
          WITH CORRESPONDING #( keys )
          RESULT DATA(headers).

    result = VALUE #( FOR header IN headers ( %tky = header-%tky
*                                              %field-Price = COND #( WHEN header-OrderStatus = accept
*                                                                     THEN if_abap_behv=>fc-f-read_only
*                                                                     ELSE if_abap_behv=>fc-f-unrestricted )
                                              %action-accepted = cond #( WHEN header-OrderStatus = accept
                                                                          THEN if_abap_behv=>fc-o-disabled
                                                                          ELSE if_abap_behv=>fc-o-enabled )
                                               %action-rejected = cond #( WHEN header-OrderStatus = reject
                                                                          THEN if_abap_behv=>fc-o-disabled
                                                                          ELSE if_abap_behv=>fc-o-enabled ) ) ).
  ENDMETHOD.

  METHOD setImageUrl.

  READ ENTITIES OF z_r_header_8150 IN LOCAL MODE
      ENTITY Header
      FIELDS ( ImageUrl )
      WITH CORRESPONDING #( keys )
      RESULT DATA(urls).

    DELETE urls WHERE ImageUrl IS NOT INITIAL.

    CHECK urls IS NOT INITIAL.

    MODIFY ENTITIES OF z_r_header_8150 IN LOCAL MODE
    ENTITY Header
    UPDATE FIELDS ( ImageUrl )
    WITH VALUE #( FOR url IN urls INDEX INTO i ( %tky = url-%tky
                                                 ImageUrl = 'https://e7.pngegg.com/pngimages/59/109/png-clipart-riot-games-round-thumbnail-tech-companies.png' ) ).
  ENDMETHOD.

ENDCLASS.

CLASS lhc_Z_R_ITEMS_8150 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Items RESULT result.

ENDCLASS.

CLASS lhc_Z_R_ITEMS_8150 IMPLEMENTATION.

  METHOD get_instance_features.


  ENDMETHOD.

ENDCLASS.
