SExp = require '../sexp'
module.exports = class Sub extends SExp
  @prefix: '-'
  @name: "Sub"
  @num_params: 2
  evaluate: () ->
    @one.evaluate() - @two.evaluate()