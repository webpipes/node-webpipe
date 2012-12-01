# EXAMPLES

Time to see node-webpipe in action. In these examples, we're going to create a simple Block that outputs the square root for an input radicand.

For example, if we input 9 (radicand) then the Block will output 3 (square root). 

## Run the Examples

Start the node-webpipe server as follows:

	node block-with-chaining.js

Test the example Block behavior with the following curl requests:

	curl -v -X OPTIONS http://localhost:3000
	
	curl -i -X POST -d '{"inputs":[{"radicand":9}]}' -H "Content-Type: application/json" http://localhost:3000
