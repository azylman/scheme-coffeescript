_ = require 'underscore'
SExp = require '../sexp'
module.exports = class Number extends SExp
  @prefix: ""
  @name: "Number"
  validate: () ->
    return "#{@values} isn't a number" if not @constructor.is @values
  @is: (string) ->
    (not _.isArray string) and (not isNaN string)
  evaluate_with_context: (context) ->
    +@values