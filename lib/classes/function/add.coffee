_ = require 'underscore'

SExp = require '../sexp'
module.exports = class Add extends SExp
  @prefix: "+"
  @name: "Add"
  evaluate_with_context: (context) ->
    base = @values[0].evaluate()
    base += @values[i].evaluate() for i in _.range 1, @values.length
    return base