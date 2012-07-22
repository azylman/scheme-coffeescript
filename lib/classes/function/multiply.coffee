_ = require 'underscore'
SExp = require '../sexp'
module.exports = class Multiply extends SExp
  @prefix: "*"
  @name: "Multiply"
  evaluate_with_context: (context) ->
    base = @values[0].evaluate_with_context context
    base *= (@values[i].evaluate_with_context context) for i in _.range 1, @values.length
    return base