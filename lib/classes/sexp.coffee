module.exports = class SExp
  constructor: (@one, @two, @three) ->
  @prefix: "????"
  evaluate: () ->
    console.log "SExp eval undefined"
  toString: () =>
    # If we're only one argument, skip the padding
    return @one if not @two

    result = "[ " + @constructor.prefix + " "
    result += @one if @one
    result += ", " + @two if @two
    result += ", " + @three if @three
    result += " ]"
    return result
