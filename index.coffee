class exports.Block
  constructor: (def, handler) ->
    if typeof def is "function"
      # This lets us do a nice DSL in CoffeeScript
      @def = {}
      def.apply this
    else
      @def = def or {}
      @handlerFn = handler

  # A cute little DSL for defining a block
  name: (name) ->
    @def.name = name
    this
  description: (description) ->
    @def.description = description
    this
  input: ->
    @_io "inputs", arguments
  output: ->
    @_io "outputs", arguments
  # Supports indexed or named args:
  _io: (type, args) ->
    @def[type] = [] unless @def[type]
    if (typeof args[0] is "object")
      @def[type].push args[0]
    else
      @def[type].push { name: args[0], type: args[1], description: args[2] }
    this

  handle: (handler) ->
    @handlerFn = handler
    this

  _validateInputs: (inputs) ->
    errors = []
    for input in @def.inputs
      # TODO: considers "null" to be missing, is this too restrictive?
      value = inputs[input.name]
      if not value? and input.required isnt false
        errors.push "Input '#{input.name}' is required."
      if value? and typeof value isnt input.type
        errors.push "Input '#{input.name}' must be a #{input.type}."
    throw errors.join "\n" unless errors.length is 0

  _handleRequest: (request, callback) ->
    inputs = request.inputs[0]
    @_validateInputs inputs
    done = (err, outputs) ->
      outputs = [outputs] unless Array.isArray(outputs)
      callback err, outputs: outputs
    if @handlerFn.length < 2
      try
        done null, @handlerFn inputs
      catch err
        done err
    else
      @handlerFn inputs, done

  nodeHandler: ->
    (req, res) => @_nodeHandler req, res

  # This does all the HTTP bits for Node.js
  _nodeHandler: (req, res) ->
    corsHeaders = (res) ->
      res.setHeader "Access-Control-Allow-Headers", "Content-Type"
      res.setHeader "Access-Control-Allow-Methods", "OPTIONS, POST"
      res.setHeader "Access-Control-Allow-Origin", "*"
    switch req.method.toUpperCase()
      when "OPTIONS"
        corsHeaders res
        res.writeHead 200, "OK", "Content-Type": "application/json; charset=utf-8"
        res.end JSON.stringify @def, null, 2
      when "POST"
        corsHeaders res
        buffer_request req, (err, body) =>
          try
            throw err if err
            request = JSON.parse(body)
            @_handleRequest request, (err, response) ->
              if err
                res.writeHead 500, "Internal Server Error"
                res.end()
              else
                res.writeHead 200, "OK", "Content-Type": "application/json; charset=utf-8"
                res.end JSON.stringify response, null, 2
          catch err
            res.writeHead 400, "Bad Request"
            res.end(String(err))
      else
        res.writeHead 405, "Method Not Allowed"
        res.end()

  # Starts the server
  listen: (port) ->
    port = port ? process.env.PORT ? 3000
    console.log "Starting '#{@def.name}' WebPipe block on port #{port}"
    require("http").createServer(@nodeHandler()).listen(port)

buffer_request = (req, callback) ->
  buffer = ""
  req.setEncoding "utf-8"
  req.on "error", (err) ->
    callback err
  req.on "data", (data) ->
    buffer += data
  req.on "end", ->
    callback null, buffer

# pipe = new webpipes.WebPipe()
#   .name( "Parse Markdown" )
#   .description( "Converts Markdown to HTML" )
#   .input( "markdown", "string", "Markdown-formatted content for transformation.")
#   .output( "html", "string", "HTML-converted data.")
#   .handler( (inputs) -> marked(inputs.markdown))
