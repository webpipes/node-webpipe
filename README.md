node-webpipe
============

A framework for creating [WebPipe](http://www.webpipes.org/) Blocks.

## USAGE 

The node-webpipe module offers two ways of creating a WebPipe Block. Both ways achieve the exact same thing, and are exposed to offer you the ability to utilize whichever pleases you the most. Additionally, you have the choice between using either JavaScript or CoffeeScript.

### Option 1: 

Create a Block by passing the Block Definition as an object.

* [JavaScript Example](./examples/block-with-definition.js)
* [CoffeeScript Example](./examples/block-with-definition.coffee)

### Option 2: 

Create a Block using the Chaining API to automagically construct the Block Definition and handler.

* [JavaScript Example](./examples/block-with-chaining.js)
* [CoffeeScript Example](./examples/block-with-chaining.coffee)