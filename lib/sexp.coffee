_ = require 'underscore'
module.exports = class SExp
  @prefix: "????"
  @name: "SExp"
  constructor: (@values, @context={}) ->
    err = @validate()
    throw new Error "failed to validate: #{err}" if err
  validate: () ->
    return 
  evaluate: () ->
    @evaluate_with_default_context {}
  evaluate_with_default_context: (context) ->
    @evaluate_with_context _.defaults context, @context
  evaluate_with_context: (context) ->
    console.log "SExp eval undefined"
  toString: () =>
    # If we're only one argument, skip the padding
    return @values if not _.isArray @values
    return @values[0].toString() if not @values[1]

    result = "[ "
    result += @constructor.prefix + " " if @constructor.prefix isnt ''
    result += @values[0].toString() if @values[0]
    result += ", " + @values[i].toString() for i in _.range 1, @values.length
    result += " ]"
    return result
