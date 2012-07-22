_ = require 'underscore'
SExp = require '../sexp.coffee'
module.exports = class Equals extends SExp
  @prefix: "="
  @name: "Equals"
  validate: () ->
    return "equals accepts 2 params, #{@values.length} were given" if @values.length isnt 2
  evaluate_with_context: (context) ->
    return @values[0].evaluate() is @values[1].evaluate()