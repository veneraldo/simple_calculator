class Z_VENER_CALCULATOR definition
  public
  final
  create public.

public section.
    TYPES:
      ty_quotient type p LENGTH 7 DECIMALS 4.
    METHODS add
      IMPORTING
        iv_first_addend  TYPE int1
        iv_second_addend TYPE int1
      RETURNING
        VALUE(rv_sum) TYPE int2.
    METHODS subtract
      IMPORTING
        iv_minuend TYPE int1
        iv_subtrahend TYPE int1
      RETURNING
        VALUE(rv_difference) TYPE int1.
     METHODS multiply
       IMPORTING
         iv_first_factor TYPE int1
         iv_second_factor TYPE int1
      RETURNING
        VALUE(rv_product) TYPE int4.
     METHODS divide
       IMPORTING
         iv_dividend TYPE int1
         iv_divisor TYPE int1
      RETURNING
         VALUE(rv_quotient) TYPE ty_quotient
      RAISING
          cx_sy_zerodivide.
ENDCLASS.


CLASS z_vener_calculator IMPLEMENTATION.

    method add.
      rv_sum = iv_first_addend + iv_second_addend.
    endmethod.
    method divide.
      rv_quotient = iv_dividend / iv_divisor.
    endmethod.
    method multiply.
      rv_product = iv_first_factor * iv_second_factor.
    endmethod.
    method subtract.
      rv_difference = iv_minuend - iv_subtrahend.
    endmethod.
endclass.


