var Block = require('../index').Block;

var block = new Block({
  "name": "Fibonacci",
  "description": "Calculates the nth Fibonacci number.",
  "url": "/block-endpoint"
  "inputs": [{
      "name": "n",
      "type": "number",
      "description": "The index of Fibonacci number to calculate."
  }],
  "outputs": [{
      "name": "fibonacci",
      "type": "number",
      "description": "The resulting Fibonacci number."
  }]
});

block.handle(function(inputs) {
  return {
      fibonacci: fib(inputs.n)
  };
})
block.listen();

// TODO: use node-fib?
function fib(n) { return n < 2 ? 1 : fib(n-2) + fib(n-1); }
