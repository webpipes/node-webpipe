var http = require('http');
var webpipes = require('../');

var block = new webpipes.Block({
  "name": "Square Root",
  "description": "Calculates the Square Root of a number.",
  "inputs": [{
      "name": "radicand",
      "type": "number",
      "description": "The number we want to find square root for."
  }],
  "outputs": [{
      "name": "square_root",
      "type": "number",
      "description": "The square root."
  }]
 }, function(inputs) {
  return { square_root: Math.sqrt(inputs.radicand) };
});
http.createServer(block.nodeHandler()).listen(process.env.PORT || 3000);