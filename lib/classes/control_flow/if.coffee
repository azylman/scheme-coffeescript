SExp = require '../sexp'
module.exports = class If extends SExp
  @prefix: "if"
  @name: "If"
  @num_params: 3
  evaluate: () ->
    if @one.evaluate() then @two.evaluate() else @three.evaluate()