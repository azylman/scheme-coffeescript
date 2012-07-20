_ = require 'underscore'
module.exports = class SExp
  @prefix: "????"
  @name: "SExp"
  constructor: (@values) ->
  evaluate: () ->
    console.log "SExp eval undefined"
  toString: () =>
    # If we're only one argument, skip the padding
    return @values if not _.isArray @values
    return @values[0] if not @values[1]

    result = "[ " + @constructor.prefix + " "
    result += @values[0] if @values[0]
    result += ", " + @values[i] for i in _.range 1, @values.length
    result += " ]"
    return result
