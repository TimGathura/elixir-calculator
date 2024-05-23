defmodule ElixirCalculatorTest do
  use ExUnit.Case
  doctest Calculator

  alias Calculator

  # < < < ADD UNIT TESTS > > >
  describe "add/2" do
    test "adds two positive numbers" do
      assert Calculator.add(3, 2) == 5
    end

    test "adds two negative numbers" do
      assert Calculator.add(-3, -2) == -5
    end

    test "adds a positive and a negative number" do
      assert Calculator.add(3, -2) == 1
    end

    test "adds zero" do
      assert Calculator.add(3, 0) == 3
    end

    test "raises OverflowError for results with more than 20 digits" do
      assert_raise OverflowError, "Value too large", fn -> Calculator.add(922337203685477580732323, 1) end
    end

    test "does not raise error for results with exactly 20 digits" do
      assert Calculator.add(9223372036854775807, 1) == 9223372036854775808
    end

    test "raises ArgumentError for non-number arguments" do
      assert_raise ArgumentError, "Invalid arguments provided. Arguments must be numbers.", fn -> Calculator.add(3, "string") end
    end
  end


  # < < < SUBTRACT UNIT TESTS > > >
  describe "subtract/2" do
    test "subtracts a larger number from a smaller one" do
      assert Calculator.subtract(5, 3) == 2
    end

    test "subtracts a smaller number from a larger one" do
      assert Calculator.subtract(3, 5) == -2
    end

    test "handles overflow for very large numbers" do
      assert_raise OverflowError, "Value too large", fn -> Calculator.subtract(922337203685477580732323, 1) end
    end
  end


  # < < < MULTIPLY UNIT TESTS > > >
  describe "multiply/2" do
    test "multiplies two positive numbers" do
      assert Calculator.multiply(3, 2) == 6
    end

    test "multiplies two negative numbers" do
      assert Calculator.multiply(-3, -2) == 6
    end

    test "handles overflow for very large numbers" do
      assert_raise OverflowError, "Value too large", fn -> Calculator.multiply(922337203685477580732323, 1) end
    end
  end


  # < < < DIVIDE UNIT TESTS > > >
  describe "divide/2" do
    test "divides two numbers" do
      assert Calculator.divide(6, 2) == 3
    end

    test "handles division by zero" do
      assert_raise ArithmeticError, fn -> Calculator.divide(6, 0) end
    end

    test "handles overflow for very large numbers" do
      assert_raise OverflowError, "Value too large", fn -> Calculator.divide(922337203685234223233775807, 1) end
    end
  end


  # < < < EXPONENT UNIT TESTS > > >
  describe "exponent/2" do
    test "calculates the exponent of a number" do
      assert Calculator.exponent(2, 3) == 8
    end

    test "calculates the exponent of a decimal number" do
      assert_in_delta Calculator.exponent(3, 2.4), 13.966610165238235, 0.0000001
    end

    test "handles overflow for very large numbers" do
      assert_raise OverflowError, "Value too large", fn -> Calculator.exponent(922337203685234223233775807, 3) end
    end

  end


  # < < < SQUARE ROOT UNIT TESTS > > >
  describe "sqrt/1" do
    test "calculates the square root of a non-negative number" do
      assert Calculator.sqrt(4) == 2
      assert Calculator.sqrt(6.5) == 2.5495097567963922
    end

    test "raises an error for a negative number" do
      assert_raise ArithmeticError, "negative argument not allowed", fn -> Calculator.sqrt(-6) end
    end
  end


  # < < < PERCENTAGE UNIT TESTS > > >
  describe "percentage/2" do
    test "calculates the percentage of a number" do
      assert Calculator.percentage(20, 100) == 20.0
      assert Calculator.percentage(45, 250) == 18.0
      assert_raise ArithmeticError, "second argument cannot be zero", fn -> Calculator.percentage(45, 0)end
    end
  end


  # < < < FACTORIAL UNIT TESTS > > >
  describe "factorial/1" do
    test "calculates the factorial of an integer" do
      assert Calculator.factorial(4) == 24
    end

    test "raises an error for a negative integer" do
      assert_raise ArithmeticError, "negative argument not allowed", fn -> Calculator.factorial(-4) end
    end

    test "raises an error for a non-integer argument" do
      assert_raise ArithmeticError, "bad argument in arithmetic expression", fn -> Calculator.factorial(4.5) end
    end
  end


  # < < < SINE UNIT TESTS > > >
  describe "sin/1" do
    test "calculates the sine of 0" do
      assert Calculator.sin(0) == 0.0
    end

    test "calculates the sine of positive values" do
      assert Calculator.sin(30) == -0.9880316240928618
    end

    test "calculates the sine of negative values" do
      assert Calculator.sin(-30) == 0.9880316240928618
    end

    test "handles unexpected input" do
      assert_raise ArithmeticError, fn -> Calculator.sin("string") end
    end
  end


  # < < < COSINE UNIT TESTS > > >
  describe "cos/1" do
    test "calculates the cosine of 0" do
      assert Calculator.cos(0) == 1.0
    end

    test "calculates the cosine of positive angle" do
      assert Calculator.cos(30) == 0.15425144988758405
    end

    test "calculates the cosine of negative angle" do
      assert Calculator.cos(-30) == 0.15425144988758405
    end

    test "handles unexpected input" do
      assert_raise ArithmeticError, fn -> Calculator.cos("string") end
    end
  end


  # < < < TANGENT UNIT TESTS > > >
  describe "tan/1" do
    test "calculates the tangent of 0" do
      assert Calculator.tan(0) == 0.0
    end

    test "calculates the tangent of positive angle" do
      assert Calculator.tan(30) == -6.405331196646276
    end

    test "calculates the tangent of negative angle" do
      assert Calculator.tan(-30) == 6.405331196646276
    end

    test "handles unexpected input" do
      assert_raise ArithmeticError, fn -> Calculator.tan("string") end
    end
  end


  # < < < ARCSINE UNIT TESTS > > >
  describe "asin/1" do
    test "calculates the arcsine of 0" do
      assert Calculator.asin(0) == 0.0
    end

    test "calculates the arcsine of 1" do
      assert Calculator.asin(1) == 1.5707963267948966
    end

    test "calculates the arcsine of -1" do
      assert Calculator.asin(-1) == -1.5707963267948966
    end

    test "handles input outside the range [-1, 1]" do
      assert_raise ArithmeticError, fn -> Calculator.asin(2) end
    end
  end


  # < < < ARCCOSINE UNIT TESTS > > >
  describe "acos/1" do
    test "calculates the arccosine of 0" do
      assert Calculator.acos(0) == 1.5707963267948966
    end

    test "calculates the arccosine of 1" do
      assert Calculator.acos(1) == 0.0
    end

    test "calculates the arccosine of -1" do
      assert Calculator.acos(-1) == 3.141592653589793
    end

    test "handles input outside the range [-1, 1]" do
      assert_raise ArithmeticError, fn -> Calculator.acos(2) end
    end
  end


  # < < < ARCTANGENT UNIT TESTS > > >
  describe "atan/1" do
    test "calculates the arctangent of 0" do
      assert Calculator.atan(0) == 0.0
    end

    test "calculates the arctangent of 1" do
      assert Calculator.atan(1) == 0.7853981633974483
    end

    test "calculates the arctangent of -1" do
      assert Calculator.atan(-1) == -0.7853981633974483
    end

    test "handles unexpected input" do
      assert_raise ArithmeticError, fn -> Calculator.atan("string") end
    end
  end


  # < < < NATURAL LOGARITHM (BASE e) UNIT TESTS > > >
  describe "ln/1" do
    test "calculates the natural logarithm of positive integer" do
      assert Calculator.ln(1) == 0.0
    end

    test "handles negative input" do
      assert_raise ArithmeticError, fn -> Calculator.ln(-1) end
    end

    test "handles zero input" do
      assert_raise ArithmeticError, fn -> Calculator.ln(0) end
    end
  end


  # < < < LOGARITHM (BASE 10) UNIT TESTS > > >
  describe "log/1" do
    test "calculates the base 10 logarithm of 1" do
      assert Calculator.log(1) == 0.0
    end

    test "calculates the base 10 logarithm of 10" do
      assert_in_delta Calculator.log(10), 1.0, :math.pow(10, -15)
    end

    test "handles negative input" do
      assert_raise ArithmeticError, fn -> Calculator.log(-1) end
    end

    test "handles zero input" do
      assert_raise ArithmeticError, fn -> Calculator.log(0) end
    end
  end


  # NO STORE, RECALL and CLEAR unit tests exit by virtue of them not being implemented in the calc_shell.exs script functionality

end
