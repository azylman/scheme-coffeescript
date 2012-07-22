_ = require 'underscore'
SExp = require '../sexp'
module.exports = class Set extends SExp
  @prefix: 'set!'
  @name: "Set"
  validate: () ->
    return "only accepts two arguments" if @values.length isnt 2
  evaluate_with_context: (context) ->
    throw new Error "symbol #{values[0]} doesn't exist" if not context[@values[0]]?
    context[@values[0]] = @values[1].evaluate_with_context context