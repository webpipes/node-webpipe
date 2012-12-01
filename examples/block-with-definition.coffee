webpipes = require('node-webpipe')

new webpipes.Block ->
  @name "Square Root"
  @description "Calculates the Square Root of a number."
  @input
    name: "radicand"
    type: "number"
    description: "The number we want to find square root for."
  @output
    name: "square_root"
    type: "number"
    description: "The square root."
  @handle (inputs) ->
    square_root: Math.sqrt inputs.radicand
# .listen()