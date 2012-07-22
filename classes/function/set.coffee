_ = require 'underscore'
SExp = require '../sexp'
Symbol = require '../primitive/symbol'
module.exports = class Set extends SExp
  @prefix: 'set!'
  @name: "Set"
  validate: () ->
    return "first argument isn't a symbol" if not Symbol.is @values[0]
    return "only accepts two arguments" if @values.length isnt 2
  evaluate_with_context: (context) ->
    throw new Error "symbol #{values[0]} doesn't exist" if not context[@values[0]]?
    context[@values[0]] = @values[1].evaluate_with_context context