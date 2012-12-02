Block = require('../index').Block

new Block ->
  @name "Fibonacci"
  @description "Calculates the nth Fibonacci number."
  @input "n", "number", "The index of Fibonacci number to calculate."
  @output "fibonacci", "number", "The resulting Fibonacci number."
  @handle (inputs) ->
    fibonacci: fib inputs.n
  @listen()

# TODO: use node-fib?
fib = (n) -> if n < 2 then 1 else fib(n-2) + fib(n-1)
