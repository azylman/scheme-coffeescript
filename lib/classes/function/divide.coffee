_ = require 'underscore'
SExp = require '../sexp'
module.exports = class Divide extends SExp
  @prefix: "/"
  @name: "Divide"
  @num_params: 2
  evaluate: () ->
    base = @values[0].evaluate()
    base /= @values[i].evaluate() for i in _.range 1, @values.length
    return base