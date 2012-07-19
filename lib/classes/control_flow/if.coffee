SExp = require '../sexp'
module.exports = class If extends SExp
  @prefix: "if"
  evaluate: () ->
    if @one.evaluate() then @two.evaluate() else @three.evaluate()