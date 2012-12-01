webpipes = require('node-webpipe')

new webpipes.Block ->
  @name "Square Root"
  @description "Calculates the Square Root of a number."
  @input "radicand", "number", "The number we want to find square root for."
  @output "square_root", "number", "The square root."
  @handle (inputs) ->
    square_root: Math.sqrt inputs.radicand
  @listen()