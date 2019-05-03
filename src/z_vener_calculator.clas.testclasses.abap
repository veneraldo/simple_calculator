*"* use this source file for your ABAP unit test classes
*"* use this source file for your ABAP unit test classes
CLASS z_vener_calculator_test definition FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
  PRIVATE SECTION.
    DATA mo_calculator TYPE REF TO zcl_simple_calculator.
    METHODS setup.
    METHODS add_2plus2_sum4 FOR TESTING.
    METHODS subtract_6minus2_dif4 FOR TESTING.
    METHODS divide_zerodivisor_exception FOR TESTING.
    METHODS teardown.
endclass.

class Z_VENER_CALCULATOR_TEST IMPLEMENTATION.
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
         iv_minuend    = 6
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
             iv_divisor   = 0 ).
         cl_abap_unit_assert=>fail(
           msg = 'CX_SY_ZERODIVIDE was not raised' ).
        CATCH cx_sy_zerodivide.
     ENDTRY.
   ENDMETHOD.

   METHOD teardown.
     CLEAR mo_calculator.
   ENDMETHOD.
ENDCLASS.
