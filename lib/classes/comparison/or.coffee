SExp = require '../sexp.coffee'
module.exports = class Or extends SExp
  @prefix: "||"
  @name: "Or"
  @num_params: 2
  evaluate: () ->
    @values[0].evaluate() or @values[1].evaluate()