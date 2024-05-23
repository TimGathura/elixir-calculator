# HTTPS: https://github.com/TimGathura/elixir-calculator.git
# SSH: git@github.com:TimGathura/elixir-calculator.git

# < < < README > > >
# 1. List of supported operations: (16)
#                                 Add, Subtract, Multiply, Divide, Exponentiation, Square root, Percentage, Factorial,
#                                 Sine, Cosine, Tangent, Arcsine, Arccosine, Arctangent, Natural log, Base 10 log
# 2. List of supported operators (in respective order): +, -, *, /, ^, sqrt, %, !, sin, cos, tan, asin, acos, atan, ln, log
# 3. Scope: Can only handle one operation at a time eg
#           > 3+3
#           Result: 6
#           > 3+3-2
#           Result: 6
# 4. Limitations: Does not handle unary operators eg > -2
#                 Does not handle parantheses appropriately eg > (7-3)
#                 Does not handle nested or sequential operations eg > 6+3-4
#                 Does not handle unsupported operators gracefully eg > 4_5
# < < < END of README > > >


# OverflowError custom exception
defmodule OverflowError do
  defexception message: "Value too large"
end


# < < < CALCULATOR MODULE: Main module containing all the calculator functions > > >
defmodule Calculator do
@moduledoc """
A simple calculator module with basic operations(20)
"""

  # < < < 1. ADD FUNCTION > > >
  @doc """
  Adds two numbers together.

  ## Examples

    iex> Calculator.add(10, 20)
    30

    iex> Calculator.add(10000000000000000000000, 10000000000000000000000)
    ** (OverflowError) Value too large
  """
  @spec add(number(), number()) :: number()
  def add(a, b) when is_number(a) and is_number(b) do
    result = a + b

    # Check if the result has more than 20 digits
    if result |> abs() |> Integer.digits() |> length() > 20 do
      raise OverflowError, message: "Value too large"
    else
      result
    end
  end

  def add(_, _) do
    raise ArgumentError, message: "Invalid arguments provided. Arguments must be numbers."
  end


  # < < < 2. SUBTRACT FUNCTION > > >
  @doc """
  Subtracts one number from another.

  ## Examples

      iex> Calculator.subtract(20, 10)
      10

      iex> Calculator.subtract(10000000000000000000000000, 1)
      ** (OverflowError) Value too large
  """
  @spec subtract(number(), number()) :: number() | {:error, String.t()}
  def subtract(a, b) when is_number(a) and is_number(b) do
    result = a - b

    # Check if the result has more than 20 digits
    if result |> abs() |> Integer.digits() |> length() > 20 do
      raise OverflowError, message: "Value too large"
    else
      result
    end
  end

  def subtract(_, _) do
    raise ArgumentError, message: "Invalid arguments provided. Arguments must be numbers."
  end


  # < < < 3. MULTIPLY FUNCTION > > >
  @doc """
  Multiplies two numbers together.

  ## Examples

      iex> Calculator.multiply(10, 20)
      200

      iex> Calculator.multiply(10000000000000000000000, 10000000000000000000000)
      ** (OverflowError) Value too large
  """
  @spec multiply(number(), number()) :: number() | {:error, String.t()}
  def multiply(a, b) when is_number(a) and is_number(b) do
    result = a * b

    # Check if the result has more than 20 digits
    if result |> abs() |> Integer.digits() |> length() > 20 do
      raise OverflowError, message: "Value too large"
    else
      result
    end
  end

  def multiply(_, _) do
    raise ArgumentError, message: "Invalid arguments provided. Arguments must be numbers."
  end


  # < < < 4. DIVIDE FUNCTION > > >
  @doc """
  Divides two numbers.

  ## Examples

      iex> Calculator.divide(2, 1)
      2.0

      iex> Calculator.divide(10000000000000000000000000000, 1)
      ** (OverflowError) Value too large
  """
  @spec divide(number(), number()) :: number() | {:error, String.t()}
  def divide(a, b) when is_number(a) and is_number(b) do
    result = a / b

    # Check if the result has more than 20 digits
    if round(result) |> Integer.digits() |> length() > 20 do
      raise OverflowError, message: "Value too large"
    else
      result
    end
  end

  def divide(_, _) do
    raise ArgumentError, message: "Invalid arguments provided. Arguments must be numbers."
  end


  # < < < 5. EXPONENT FUNCTION > > >
  @doc """
  Returns the exponent of a number given two values.

  ## Examples

      iex> Calculator.exponent(2, 3)
      8.0

      iex> Calculator.exponent(3, 2.4)
      13.966610165238235

      iex> Calculator.exponent(10000000000000000000000000000, 4)
      ** (OverflowError) Value too large
  """
  @spec exponent(number(), number()) :: number() | {:error, String.t()}
  def exponent(base, power) when is_number(base) and is_number(power) do
    result = :math.pow(base, power)

    if round(result) |> Integer.digits() |> length() > 20 do
      raise OverflowError, message: "Value too large"
    else
      result
    end
  end

  def exponent(_, _) do
    {:error, "Invalid arguments provided. Arguments must be numbers."}
  end


  # < < < 6. SQUARE ROOT FUNCTION > > >
  @doc """
  Calculates the square root of a non-negative number

  ## Examples
      iex> Calculator.sqrt(4)
      2.0

      iex> Calculator.sqrt(6.5)
      2.5495097567963922

      iex> Calculator.sqrt(-6)
      ** (ArithmeticError) negative argument not allowed
  """
  @spec sqrt(number()) :: number() | {:error, String.t()}
  def sqrt(n) when is_number(n) do
    try do
      if n < 0 do
        raise ArithmeticError, "negative argument not allowed"
      else
        :math.sqrt(n)
      end
    rescue
      ArithmeticError ->
        raise ArithmeticError, "negative argument not allowed"
    end
  end

  def sqrt(_) do
    {:error, "Invalid argument provided. Argument must be a number."}
  end


  # < < < 7. PERCENTAGE FUNCTION > > >
  @doc """
  Calculates the percentage of a number

  ## Examples
      iex> Calculator.percentage(20,100)
      20.0

      iex> Calculator.percentage(45,250)
      18.0

      iex> Calculator.percentage(7,0)
      ** (ArithmeticError) second argument cannot be zero

  """
  @spec percentage(number(), number()) :: number() | {:error, String.t()}
  def percentage(number, total) when is_number(number) and is_number(total) do
    try do
      if total == 0 do
        raise ArithmeticError, "second argument cannot be zero"
      else
        result = (number / total) * 100
        result
      end
    rescue
      ArithmeticError ->
        raise ArithmeticError, "second argument cannot be zero"
    end
  end

  def percentage(_, _) do
    {:error, "Invalid arguments provided. Arguments must be numbers."}
  end


  # < < < 8. FACTORIAL FUNCTION > > >
  @doc """
  Calculates the factorial of a non-negative integer.

  ## Examples
      iex> Calculator.factorial(4)
      24

      iex> Calculator.factorial(-4)
      ** (ArithmeticError) negative argument not allowed

      iex> Calculator.factorial(4.5)
      ** (ArithmeticError) bad argument in arithmetic expression
  """
  @spec factorial(non_neg_integer()) :: non_neg_integer() | {:error, String.t()}
  def factorial(n) when is_integer(n) do
    try do
      if n < 0 do
        raise ArithmeticError, "negative argument not allowed"
      else
        do_factorial(n)
      end
    rescue
      ArithmeticError ->
        raise ArithmeticError, "negative argument not allowed"
    end
  end

  def factorial(n) when is_float(n) do
    raise ArithmeticError, message: "bad argument in arithmetic expression"
  end

  def factorial(_) do
    {:error, "Invalid argument provided. Argument must be a non-negative integer."}
  end

  defp do_factorial(0), do: 1
  defp do_factorial(n), do: n * do_factorial(n - 1)


  # < < < 9. SINE FUNCTION > > >
  @doc """
  Calculates the sine of an angle in radians.

  ## Examples
      iex> Calculator.sin(0.0)
      0.0

      iex> Calculator.sin(30)
      -0.9880316240928618

      iex> Calculator.sin(-30)
      0.9880316240928618

      iex> Calculator.sin(true)
      ** (ArithmeticError) bad argument in arithmetic expression

  """
  @spec sin(number()) :: number() | {:error, String.t()}
  def sin(angle) when is_number(angle) do
    result = :math.sin(angle)
    result

  end


    def sin(_) do
      raise(ArithmeticError, message: "bad argument in arithmetic expression")
    end


  # < < < 10. COSINE FUNCTION > > >
  @doc """
  Calculates the cosine of an angle in radians.

  ## Examples
      iex> Calculator.cos(0.0)
      1.0

      iex> Calculator.cos(30)
      0.15425144988758405

      iex> Calculator.cos(-30)
      0.15425144988758405

      iex> Calculator.cos("string")
      ** (ArithmeticError) bad argument in arithmetic expression

  """
  @spec cos(number()) :: number() | {:error, String.t()}
  def cos(angle) when is_number(angle) do
    result = :math.cos(angle)
    result

  end


  def cos(_) do
    raise(ArithmeticError, message: "bad argument in arithmetic expression")
  end


  # < < < 11. TANGENT FUNCTION > > >
  @doc """
  Calculates the tan of an angle in radians.

  ## Examples
      iex> Calculator.tan(0.0)
      0.0

      iex> Calculator.tan(30)
      -6.405331196646276

      iex> Calculator.tan(-30)
      6.405331196646276

      iex> Calculator.tan("string")
      ** (ArithmeticError) bad argument in arithmetic expression

  """
  @spec tan(number()) :: number() | {:error, String.t()}
  def tan(angle) when is_number(angle) do
    result = :math.tan(angle)
    result
  end


  def tan(_) do
    raise ArithmeticError, "bad argument in arithmetic expression"
  end


  # < < < 12. ARCSINE FUNCTION > > >
  @doc """
  Calculates the arcsine of an angle in radians.

  ## Examples
      iex> Calculator.asin(0.0)
      0.0

      iex> Calculator.asin(1)
      1.5707963267948966

      iex> Calculator.asin(-1)
      -1.5707963267948966

      iex> Calculator.asin("string")
      ** (ArithmeticError) bad argument in arithmetic expression: must be between -1 and 1

  """
  @spec asin(number()) :: number() | {:error, String.t()}
  def asin(value) when is_number(value) and value >= -1 and value <= 1 do
    result = :math.asin(value)
    result
  end


  def asin(_) do
    raise(ArithmeticError, message: "bad argument in arithmetic expression: must be between -1 and 1")
  end


  # < < < 13. ARCCOSINE FUNCTION > > >
  @doc """
  Calculates the arcosine of an angle in radians.

  ## Examples
      iex> Calculator.acos(0.0)
      1.5707963267948966

      iex> Calculator.acos(1)
      0.0

      iex> Calculator.acos(-1)
      3.141592653589793

      iex> Calculator.acos("string")
      ** (ArithmeticError) bad argument in arithmetic expression: must be between -1 and 1

  """
  @spec acos(number()) :: number() | {:error, String.t()}
  def acos(value) when is_number(value) and value >= -1 and value <= 1 do
    result = :math.acos(value)
    result
  end


  def acos(_) do
    raise(ArithmeticError, message: "bad argument in arithmetic expression: must be between -1 and 1")
  end


  # < < < 14. ARCTANGENT FUNCTION > > >
  @doc """
  Calculates the arctangent of an angle in radians.

  ## Examples
      iex> Calculator.atan(0.0)
      0.0

      iex> Calculator.atan(1)
      0.7853981633974483

      iex> Calculator.atan(-1)
      -0.7853981633974483

      iex> Calculator.atan("string")
      ** (ArithmeticError) bad argument in arithmetic expression: must be between -1 and 1

  """
  @spec atan(number()) :: number() | {:error, String.t()}
  def atan(value) when is_number(value) and value >= -1 and value <= 1 do
    result = :math.atan(value)
    result
  end


  def atan(_) do
    raise(ArithmeticError, message: "bad argument in arithmetic expression: must be between -1 and 1")
  end


  # < < < 15. NATURAL LOGARITHM FUNCTION (BASE e) > > >
  @doc """
  Calculates the natural logarithm (base e) of a number.

  ## Examples
      iex> Calculator.ln(10)
      2.302585092994046

      iex> Calculator.ln(0)
      ** (ArithmeticError) bad argument in arithmetic expression: can only be a positive non-zero value

      iex> Calculator.ln(-6)
      ** (ArithmeticError) bad argument in arithmetic expression: can only be a positive non-zero value
  """
  @spec ln(number()) :: number() | {:error, String.t()}
  def ln(value) when is_number(value) and value > 0 do
    result = :math.log(value)
    result
  end

  def ln(_) do
    raise(ArithmeticError, message: "bad argument in arithmetic expression: can only be a positive non-zero value")
  end


  # < < < 16. LOGARITHM FUNCTION (BASE 10) > > >
  @doc """
  Calculates the logarithm (base 10) of a number.

  ## Examples
      iex> Calculator.log(10)
      1.0

      iex> Calculator.log(0)
      ** (ArithmeticError) bad argument in arithmetic expression: can only be a positive non-zero value

      iex> Calculator.log(-6)
      ** (ArithmeticError) bad argument in arithmetic expression: can only be a positive non-zero value
  """
  @spec log(number()) :: number() | {:error, String.t()}
  def log(value) when is_number(value) and value > 0 do
    result = :math.log10(value)
    result
  end

  def log(_) do
    raise(ArithmeticError, message: "bad argument in arithmetic expression: can only be a positive non-zero value")
  end






# - - - - - STORE, RECALL and CLEAR functions work but only be being directly invoked: cannot work directly in the Calculator shell - - - -

  # < < < 17. STORE FUNCTION > > >
    # @spec store(atom(), number()) :: :ok

    # def store(key, value) when is_atom(key) and is_number(value) do
    #     Agent.start_link(fn -> %{} end, name: __MODULE__)
    #     Agent.update(__MODULE__, fn state -> Map.put(state, key, value) end)
    #     :ok
    # end


  # < < < 18. RECALL FUNCTION > > >

    # @spec recall(atom()) :: number() | nil

    # def recall(key) when is_atom(key) do
    #     Agent.get(__MODULE__, fn state -> Map.get(state, key) end)
    # end


  # < < < 19. CLEAR FUNCTION > > >
    # @spec clear() :: :ok

    # def clear() do
    #     Agent.update(__MODULE__, fn _ -> %{} end)
    #     :ok
    # end

end










# Tokenizer = Splits the string input from the user and returns a list of elements to the Parser
# Parser = Works only for single operations [sin30, 3+3]. Does not handle nested operations [sin30 + 45]
# Evaluator = Dependent on Parser for script output. It calls the associated functions for separation of concerns.

# < < < TOKENIZER MODULE > > >
# Alias Module for speedy use of the Tokenizer module
defmodule A do
  alias Tokenizer, as: A
  def a(expression), do: A.tokenize(expression)
end

defmodule Tokenizer do
  #@operators ~w(+ - * / ^)
  #@parentheses ["(", ")"]

  def tokenize(expression) do
    expression
    |> String.trim()                        # Remove leading and trailing whitespaces
    |> String.replace(~r/\s+/, "")         # Remove whitespaces between characters
    |> String.split(~r/(?<=\D)(?=\d)|(?<=\d)(?=\D)|(?<=\D)(?=\()|(?<=\))(?=\D)|(?<=\()|(?=\))/)  # Split based on explicit rules
    |> Enum.reject(&(&1 == ""))            # Remove empty entries
  end
end


# < < < PARSER MODULE > > >
defmodule Parser do

  # Prefix operators
  def parse(["sin" | [operand | _rest]]) do
    Calculator.sin(String.to_integer(operand))
  end

  def parse(["cos" | [operand | _rest]]) do
    Calculator.cos(String.to_integer(operand))
  end

  def parse(["tan" | [operand | _rest]]) do
    Calculator.tan(String.to_integer(operand))
  end

  def parse(["asin" | [operand | _rest]]) do
    Calculator.asin(String.to_integer(operand))
  end

  def parse(["acos" | [operand | _rest]]) do
    Calculator.acos(String.to_integer(operand))
  end

  def parse(["atan" | [operand | _rest]]) do
    Calculator.atan(String.to_integer(operand))
  end

  def parse(["ln" | [operand | _rest]]) do
    Calculator.ln(String.to_integer(operand))
  end

  def parse(["log" | [operand | _rest]]) do
    Calculator.log(String.to_integer(operand))
  end

  def parse(["sqrt" | [operand | _rest]]) do
    Calculator.sqrt(String.to_integer(operand))
  end


  # Infix operators
  def parse([operand1, "+", operand2 | _rest]) do
    Calculator.add(String.to_integer(operand1), String.to_integer(operand2))
  end

  def parse([operand1, "-" , operand2 | _rest]) do
    Calculator.subtract(String.to_integer(operand1), String.to_integer(operand2))
  end

  def parse([operand1, "*" , operand2 | _rest]) do
    Calculator.multiply(String.to_integer(operand1), String.to_integer(operand2))
  end

  def parse([operand1, "/" , operand2 | _rest]) do
    Calculator.divide(String.to_integer(operand1), String.to_integer(operand2))
  end

  def parse([operand1, "^" , operand2 | _rest]) do
    Calculator.exponent(String.to_integer(operand1), String.to_integer(operand2))
  end


  # Suffix operators
  def parse([operand, "!" | _rest]) do
    Calculator.factorial(String.to_integer(operand))
  end

  def parse([operand1, operand2, "%"]) do
    with {:ok, number} <- safe_to_integer(operand1),
         {:ok, total} <- safe_to_integer(operand2) do
      Calculator.percentage(number, total)
    else
      error -> error
    end
  end

  # Exception for invalid values
  def parse(_) do
    {:error, "Invalid operator or operands"}
  end

  defp safe_to_integer(value) do
    case Integer.parse(value) do
      {number, ""} -> {:ok, number}
      _ -> {:error, "Invalid argument: #{value} is not an integer"}
    end
  end
end


# < < < EVALUATOR MODULE > > >
defmodule Evaluator do
  def eval(ast) do
    case ast do

      # Prefix operator evaluators
      ["sin", operand] ->
        Calculator.sin(eval(operand))

      ["cos", operand] ->
        Calculator.cos(eval(operand))

      ["tan", operand] ->
        Calculator.tan(eval(operand))

      ["asin", operand] ->
        Calculator.asin(eval(operand))

      ["acos", operand] ->
        Calculator.acos(eval(operand))

      ["atan", operand] ->
        Calculator.atan(eval(operand))

      ["ln", operand] ->
        Calculator.ln(eval(operand))

      ["log", operand] ->
        Calculator.log(eval(operand))

      ["sqrt", operand] ->
        Calculator.sqrt(eval(operand))


      # Infix operator evaluators
      [operand1, "+", operand2] ->
        Calculator.add(eval(operand1), eval(operand2))

      [operand1, "-", operand2] ->
        Calculator.subtract(eval(operand1), eval(operand2))

      [operand1, "*", operand2] ->
        Calculator.multiply(eval(operand1), eval(operand2))

      [operand1, "/", operand2] ->
        Calculator.divide(eval(operand1), eval(operand2))

      [operand1, "^", operand2] ->
        Calculator.exponent(eval(operand1), eval(operand2))


      # Suffix operator evaluators
      [operand, "!"] ->
        Calculator.factorial(eval(operand))

      [operand1, operand2, "%"] ->
        Calculator.percentage(eval(operand1), eval(operand2))

      operand when is_number(operand) ->
        operand

      operand ->
        eval(operand)

    end
  end
end
