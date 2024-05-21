# HTTPS: https://github.com/TimGathura/elixir-calculator.git
# SSH: git@github.com:TimGathura/elixir-calculator.git

# All calculator functions will come here

# Main module containing all the calculator functions

defmodule Calculator do
@moduledoc """
A simple calculator module with basic operations(20)
"""

    @doc """
    Starts the calculator
    """
    #def start() do
        #run()
    #end

    # 1. Addition function
    @spec add(number(), number()) :: number()
    def add(a,b) do
        a + b
    end

    # 2. Subtraction function
    @spec subtract(number(), number()) :: number()
    def subtract(a,b) do
        a - b
    end

    # 3. Multiplication function
    # IDIOMATICITY: multiply() instead of mult() for more idiomatic code
    @spec multiply(number(), number()) :: number()
    def multiply(a,b) do
        a * b
    end


    # 4. Division function
    @doc """
    Divides two numbers

    ## Examples

        iex> Calculator.divide(3,2)
        1.5

        iex> Calculator.divide(6, 2.1)
        2.8571

        iex> Calculator.divide(4,0)
        ** (ArithmeticError) bad argument in arithmetic expression
    """
    @spec divide(number(), number()) :: number()

    def divide(a,b) do
        a / b
    end


    # 5. Exponent function
    @doc """
    Returns the exponent of a number given two values

    ## Examples

        iex> Calculator.exponent(2,3)
        8

        iex> Calculator.exponent(3,2.4)
        13.9666
    """
    @spec exponent(number(), number()) :: number()

    def exponent(base, power) do
        :math.pow(base, power)
    end


    # 6. Square root function
    @doc """
    Calculates the square root of a non-negative number

    ## Examples
        iex> Calculator.sqrt(4)
        2

        iex> Calculator.sqrt(6.5)
        2.5495

        iex> Calculator.sqrt(-6)
        ** (ArithmeticError) bad argument in arithmetic expression
    """
    @spec sqrt(number()) :: number()

    def sqrt(n) when n < 0 do
      raise ArithmeticError, "sqrt: negative argument"
    end
    def sqrt(n) do
      :math.sqrt(n)
    end


    # 7. Percentage function
    @doc """
    Calculates the percentage of a number

    ## Examples
        iex> Calculator.percentage(20,100)
        20.0

        iex> Calculator.percentage(45,250)
        18.0
    """
    @spec percentage(number(), number()) :: number()

    def percentage(number,total) do
      (number / total) * 100
    end


    # 8. Factorial function
    @doc """
    Calculates the factorial of an integer

    ## Examples
        iex> Calculator.factorial(4)
        24

        iex> Calculator.factorial(-4)
        ** (ArithmeticError) bad argument in arithmetic expression

        iex> Calculator.factorial((-4))
        ** (ArithmeticError) bad argument in arithmetic expression

        iex> Calculator.factorial(4.5)
        ** (ArithmeticError) bad argument in arithmetic expression
    """
    @spec factorial(non_neg_integer()) :: non_neg_integer()

    def factorial(0), do: 1
    def factorial(n), do: n * factorial(n-1)


    # 9. Store Value function
    @doc """
    Stores a value in memory using a specified key.

    ## Examples
        iex> Calculator.store(:A, 10)
        :ok

        iex> Calculator.store(:B, 20)
        :ok
    """
    @spec store(atom(), number()) :: :ok

    def store(key, value) when is_atom(key) and is_number(value) do
        Agent.start_link(fn -> %{} end, name: __MODULE__)
        Agent.update(__MODULE__, fn state -> Map.put(state, key, value) end)
        :ok
    end


    # 10. Recall Value function
    @doc """
    Retrieves a value from memory using a specified key.

    ## Examples
        iex> Calculator.recall(:A)
        10

        iex> Calculator.recall(:C)
        nil
    """
    @spec recall(atom()) :: number() | nil

    def recall(key) when is_atom(key) do
        Agent.get(__MODULE__, fn state -> Map.get(state, key) end)
    end


    # 11. Clear Memory
    @doc """
    Clears all stored values from memory.

    ## Examples
        iex> Calculator.clear()
        :ok
    """
    @spec clear() :: :ok

    def clear() do
        Agent.update(__MODULE__, fn _ -> %{} end)
        :ok
    end


    # 12. Sine function
    @doc """
    Calculates the sine of an angle in radians.

    ## Examples
        iex> Calculator.sin(0.0)
        0.0

        iex> Calculator.sin(:math.pi / 2)
        1.0

        iex> Calculator.sin(:math.pi)
        1.2246467991473532e-16
    """
    @spec sin(number()) :: number()

    def sin(angle) do
        :math.sin(angle)
    end


    # 13. Cosine function
    @doc """
    Calculates the cosine of an angle in radians.

    ## Examples
        iex> Calculator.cos(0.0)
        1.0

        iex> Calculator.cos(:math.pi / 2)
        6.123233995736766e-17

        iex> Calculator.cos(:math.pi)
        -1.0
    """
    @spec cos(number()) :: number()

    def cos(angle) do
        :math.cos(angle)
    end


    # 14. Tangent function
    @doc """
    Calculates the tangent of an angle in radians.

    ## Examples
        iex> Calculator.tan(0.0)
        0.0

        iex> Calculator.tan(:math.pi / 4)
        0.9999999999999999

        iex> Calculator.tan(:math.pi)
        -1.2246467991473532e-16
    """
    @spec tan(number()) :: number()

    def tan(angle) do
        :math.tan(angle)
    end


    # 15. Arcsine Function
    @doc """
    Calculates the inverse sine (arcsine) of a number.

    ## Examples
        iex> Calculator.asin(0.0)
        0.0

        iex> Calculator.asin(1.0)
        1.5707963267948966

        iex> Calculator.asin(-1.0)
        -1.5707963267948966
    """
    @spec asin(number()) :: number()

    def asin(x) do
        :math.asin(x)
    end


    # 16. Arccosine function
    @doc """
    Calculates the inverse cosine (arccosine) of a number.

    ## Examples
        iex> Calculator.acos(1.0)
        0.0

        iex> Calculator.acos(0.0)
        1.5707963267948966

        iex> Calculator.acos(-1.0)
        3.141592653589793
    """
    @spec acos(number()) :: number()

    def acos(x) do
        :math.acos(x)
    end


    # 17. Arctangent function
    @doc """
    Calculates the inverse tangent (arctangent) of a number.

    ## Examples
        iex> Calculator.atan(0.0)
        0.0

        iex> Calculator.atan(1.0)
        0.7853981633974483

        iex> Calculator.atan(-1.0)
        -0.7853981633974483
    """
    @spec atan(number()) :: number()

    def atan(x) do
        :math.atan(x)
    end


    # 18. Natural Logarithm Function
    @doc """
    Calculates the natural logarithm (base e) of a number.

    ## Examples
        iex> Calculator.ln(1.0)
        0.0

        iex> Calculator.ln(Math.e)
        1.0

        iex> Calculator.ln(10.0)
        2.302585092994046
    """
    @spec ln(number()) :: number()

    def ln(x) when x > 0 do
        :math.log(x)
    end


    # 19. Logarithm base-10 function
    @doc """
    Calculates the base-10 logarithm of a number.

    ## Examples
        iex> Calculator.log10(1.0)
        0.0

        iex> Calculator.log10(10.0)
        1.0

        iex> Calculator.log10(100.0)
        2.0
    """
    @spec log10(number()) :: number()

    def log10(x) when x > 0 do
        :math.log10(x)
    end

end








defmodule Tokenizer do
    def tokenize(expression) do
      expression
      |> String.trim()
      |> String.graphemes()
      |> Enum.chunk_by(&(&1 in [" ", "+", "-", "*", "/", "(", ")"]))
      |> Enum.filter(&(&1 != " "))
      |> Enum.map(&Enum.join/1)
    end
end

defmodule Parser do
    def parse(tokens) do
      {ast, _} = parse_expression(tokens)
      ast
    end

    defp parse_expression(tokens) do
      {left, tokens} = parse_term(tokens)
      parse_expression(left, tokens)
    end

    defp parse_expression(left, []), do: {left, []}
    defp parse_expression(left, [op | tokens]) when op in ["+", "-"] do
      {right, tokens} = parse_term(tokens)
      parse_expression({op, left, right}, tokens)
    end
    defp parse_expression(left, tokens), do: {left, tokens}

    defp parse_term(tokens) do
      {left, tokens} = parse_factor(tokens)
      parse_term(left, tokens)
    end

    defp parse_term(left, []), do: {left, []}
    defp parse_term(left, [op | tokens]) when op in ["*", "/"] do
      {right, tokens} = parse_factor(tokens)
      parse_term({op, left, right}, tokens)
    end
    defp parse_term(left, tokens), do: {left, tokens}

    defp parse_factor(["(" | tokens]) do
      {expr, [")" | tokens]} = parse_expression(tokens)
      {expr, tokens}
    end

    defp parse_factor([num | tokens]) do
      case Float.parse(num) do
        {float, ""} -> {float, tokens}
        :error -> raise ArgumentError, "Not a valid float: #{num}"
      end
    end
end


defmodule Evaluator do
    def eval(ast) do
      case ast do
        {"+", left, right} -> eval(left) + eval(right)
        {"-", left, right} -> eval(left) - eval(right)
        {"*", left, right} -> eval(left) * eval(right)
        {"/", left, right} -> eval(left) / eval(right)
        num when is_number(num) -> num
      end
    end
end
