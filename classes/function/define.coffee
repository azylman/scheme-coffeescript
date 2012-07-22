_ = require 'underscore'
SExp = require '../sexp'
Symbol = require '../primitive/symbol'
module.exports = class Define extends SExp
  @prefix: 'define'
  @name: "Define"
  validate: () ->
    return "first argument isn't a symbol" if not Symbol.is @values[0]
    return "only accepts two arguments" if @values.length isnt 2
  evaluate_with_context: (context) ->
    context[@values[0].evaluate_with_context context] = @values[1].evaluate_with_context context