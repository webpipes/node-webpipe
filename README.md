node-webpipe
============

A minimal framework for creating [WebPipe](http://www.webpipes.org/) blocks (and eventually triggers).

## Usage 

The Block API does 3 things for you:

- Declare the block metadata like name, description, inputs, and outputs.
- Provide a function (either synchronous or asynchronous) that implements the block.
- Start an HTTP server on a specified port, or get a handler for use with a Node.js HTTP server or framework.

The server will automatically handle the WebPipe's `OPTIONS` request, and parsing/serializing the inputs/outputs before invoking your handler function.

### Metadata

There are three ways to declare the metadata and handler function.

Use the chaining API:

    block = new Block()
      .name("Square Root")
      .description("Calculates the Square Root of a number.")
      .input("radicand", "number", "The number we want to find square root for.")
      .output("square_root", "number", "The square root.");

Pass a function to the constructor, which binds the new object to "this" inside the function. This works great with CoffeeScript:

    block = new Block ->
      @name "Square Root"
      @description "Calculates the Square Root of a number."
      @input "radicand", "number", "The number we want to find square root for."
      @output "square_root", "number", "The square root."

Pass a standard WebPipe "Block" descriptor to the constructor:

    block = new Block({
      "name": "Square Root",
      "description": "Calculates the Square Root of a number.",
      "inputs": [{
        "name": "radicand",
        "type": "number",
        "description": "The square root."
      }],
      "outputs": [{
        "name": "square_root",
        "type": "number",
        "description": "The square root."
      }]
    })

### Handler

A handler with an `inputs` argument is added to the block using the `handle` method:

    block.handle(function(inputs) {
      return {
        square_root: Math.sqrt(inputs.radicand)
      };
    })

In this case the return value is used as the `outputs` object.

Declare the second `callback` argument to put the block in asynchronous mode. Pass the `outputs` object to the callback when it's done:

    block.handle(function(inputs, callback) {
      setTimeout(function() {
        callback({
          square_root: Math.sqrt(inputs.radicand)
        });
      }, 1000);
    })

### Server

You can start a simple webserver on the specified port using the `listen` method:

    block.listen(3000)

If the port number is omitted it will check process.env for the `PORT` key, or use 3000 by default:

    block.listen()

You can also get a Node.js HTTP server compatible request handler. This is equivalent to the above examples:

    require("http").createServer(block.nodeHandler()).listen(3000);
