SExp = require '../sexp.coffee'
module.exports = class Greater extends SExp
  @prefix: ">"
  @name: "Greater"
  @num_params: 2
  evaluate: () ->
    @values[0].evaluate() > @values[1].evaluate()