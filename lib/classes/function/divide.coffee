SExp = require '../sexp'
module.exports = class Divide extends SExp
  @prefix: "/"
  @name: "Divide"
  @num_params: 2
  evaluate: () ->
    @one.evaluate() / @two.evaluate()