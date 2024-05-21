# scripts/calc_shell.exs

# Explicitly require the calculator module file
Code.require_file("../lib/calculator.ex", __DIR__)

IO.puts "Welcome to the Elixir Calculator. Type 'exit' to quit."

defmodule InteractiveCalculator do
  def start do
    loop()
  end

  defp loop do
    input = IO.gets("> ")

    case String.trim(input) do
      "exit" -> IO.puts("Goodbye!")
      expr ->
        tokens = Tokenizer.tokenize(expr)
        ast = Parser.parse(tokens)
        result = Evaluator.eval(ast)
        IO.puts("Result: #{result}")
        loop()
    end
  end
end

InteractiveCalculator.start()
