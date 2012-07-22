_ = require 'underscore'
SExp = require '../sexp'
module.exports = class Define extends SExp
  @prefix: 'define'
  @name: "Define"
  validate: () ->
    return "only accepts two arguments" if @values.length isnt 2
  evaluate_with_context: (context) ->
    context[@values[0]] = @values[1].evaluate_with_context context