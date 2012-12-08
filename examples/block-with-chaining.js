var Block = require('../index').Block;

new Block()
  .name("Fibonacci")
  .description("Calculates the nth Fibonacci number.")
	.url("/block-endpoint")
  .input("n", "number", "The index of Fibonacci number to calculate.")
  .output("fibonacci", "number", "The resulting Fibonacci number.")
  .handle(function(inputs) {
    return {
        fibonacci: fib(inputs.n)
    };
  })
  .listen()

// TODO: use node-fib?
function fib(n) { return n < 2 ? 1 : fib(n-2) + fib(n-1); }
