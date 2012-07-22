_ = require 'underscore'

SExp = require '../sexp'
module.exports = class Sub extends SExp
  @prefix: '-'
  @name: "Sub"
  evaluate_with_context: (context) ->
    base = @values[0].evaluate()
    base -= @values[i].evaluate() for i in _.range 1, @values.length
    return base