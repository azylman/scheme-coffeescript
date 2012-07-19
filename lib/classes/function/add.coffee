SExp = require '../sexp'
module.exports = class Add extends SExp
  @prefix: "+"
  evaluate: () ->
    @one.evaluate() + @two.evaluate()