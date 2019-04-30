* Class Under Test
CLASS zcl_simple_calculator DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.
  PUBLIC SECTION.
    TYPES:
      ty_quotient type p LENGTH 7 DECIMALS 4 .
    METHODS add
      IMPORTING
        i v_first_addend TYPE int1
        i v_second_addend TYPE int1
      RETURNING
        VALUE(rv_sum) TYPE int2.
    METHODS subtract
      IMPORTING
        i v_minuend TYPE int1
        i v_subtrahend TYPE int1
      RETURNING
        VALUE(rv_difference) TYPE int1.
     METHODS multiply
      IMPORTING
        i v_first_factor TYPE int1
        i v_second_factor TYPE int1
      RETURNING
        VALUE(rv_product) TYPE int4.
     METHODS divide
      IMPORTING
        i v_dividend TYPE int1
        i v_divisor TYPE int1
      RETURNING
        VALUE(rv_quotient) TYPE ty_quotient
      RAISING
         cx_sy_zerodivide.
ENDCLASS.

CLASS zcl_simple_calculator IMPLEMENTATION.
  METHOD add.
     rv_sum = iv_first_addend + iv_second_addend.
  ENDMETHOD.
  METHOD divide.
     rv_quotient = iv_dividend / iv_divisor.
  ENDMETHOD. 
  METHOD multiply.
     rv_product = iv_first_factor * iv_second_factor.
  ENDMETHOD.
  METHOD subtract.
     rv_difference = iv_minuend * iv_subtrahend.
  ENDMETHOD.
ENDCLASS.

* Unit Test Class
CLASS zltc_simple_calculator_test definition FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA mo_calculator TYPE REF TO zcl_simple_calculator.
    METHODS setup.
    METHODS add_2plus2_sum4 FOR TESTING.
    METHODS subtract_6minus2_dif4 FOR TESTING.
    METHODS divide_zerodivisor_exception FOR TESTING.
    METHODS teardown.
ENDCLASS.

CLASS ZLTC_SIMPLE_CALCULATOR_TEST IMPLEMENTATION.
  METHOD setup.
    CREATE OBJECT mo_calculator.
  ENDMETHOD.

  METHOD add_2plus2_sum4.
    DATA lv_expected  TYPE int2 VALUE 4.
    DATA lv_sum       TYPE int2.
    lv_sum = mo_calculator->add(
      EXPORTING
        iv_first_addend  = 2
        iv_second_addend = 2 ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = lv_sum
        exp = lv_expected
        msg = 'Calculator Addtion Test Failed' ).
   ENDMETHOD.

   METHOD subtract_6minus2_dif4.
    DATA lv_expected  TYPE int2 VALUE 4.
    DATA lv_difference      TYPE int2.
    lv_difference = mo_calculator->subtract(
      EXPORTING
        iv_minuend  = 6
        iv_subtrahend = 2 ).
    cl_abap_unit_assert=>assert_equals(
      EXPORTING
        act = lv_difference
        exp = lv_expected
        msg = 'Calculator Subtraction Test Failed' ).
   ENDMETHOD.  
   
   METHOD divide_zerodivisor_exception.
     TRY.
         mo_calculator->divide(
           EXPORTING
             iv_dividend  = 5
             iv_divisor = 0 ).
         cl_abap_unit_assert=>fail(
           msg = 'CX_SY_ZERODIVIDE was not raised' ).
     CATCH cx_sy_zerodivide.
   ENDMETHOD. 

   METHOD teardown.
     CLEAR mo_calculator.
   ENDMETHOD.
ENDCLASS.


