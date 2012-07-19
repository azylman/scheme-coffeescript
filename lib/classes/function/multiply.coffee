SExp = require '../sexp'
module.exports = class Multiply extends SExp
  @prefix: "*"
  @name: "Multiply"
  @num_params: 2
  evaluate: () ->
    @one.evaluate() * @two.evaluate()