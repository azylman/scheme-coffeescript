_ = require 'underscore'
SExp = require '../sexp'
module.exports = class Multiply extends SExp
  @prefix: "*"
  @name: "Multiply"
  evaluate: () ->
    base = @values[0].evaluate()
    base *= @values[i].evaluate() for i in _.range 1, @values.length
    return base