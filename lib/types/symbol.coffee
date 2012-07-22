_ = require 'underscore'
SExp = require '../sexp'
Number = require './number'
Bool = require './bool'
module.exports = class Symbol extends SExp
  @prefix: ""
  @name: "Symbol"
  validate: () ->
    return "#{@values} isn't a symbol" if not @constructor.is @values
  @is: (string) ->
    (not _.isArray string) and (not Number.is string) and not Bool.is string
  evaluate_with_context: (context) ->
    throw new Error "#{@values} is undefined" if not context[@values]?
    return context[@values]