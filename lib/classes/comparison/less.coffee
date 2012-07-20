SExp = require '../sexp.coffee'
module.exports = class Less extends SExp
  @prefix: "<"
  @name: "Less"
  @num_params: 2
  evaluate: () ->
    @values[0].evaluate() < @values[1].evaluate()