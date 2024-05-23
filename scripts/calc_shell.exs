Code.require_file("../lib/calculator.ex", __DIR__)


defmodule InteractiveCalculator do
  def run do
    IO.puts("Welcome to the Elixir Calculator. Type 'exit' to quit.")
    loop()
  end

  defp loop do
    input = IO.gets("> ")

    case String.trim(input) do
      "exit" -> IO.puts("Goodbye!")
      expr ->
        case parse_expression(expr) do
          {:ok, result} ->
            IO.puts("Result: #{result}")
            loop()
          {:error, reason} ->
            IO.puts("Error: #{reason}")
            loop()
        end
    end
  end

  defp parse_expression(expr) do
    try do
      tokens = Tokenizer.tokenize(expr)
      ast = Parser.parse(tokens)
      {:ok, Evaluator.eval(ast)}
    rescue
      ArgumentError -> {:error, "Invalid input"}
      e -> {:error, Exception.message(e)}
    end
  end
end


InteractiveCalculator.run()
