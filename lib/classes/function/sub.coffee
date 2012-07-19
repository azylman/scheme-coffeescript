SExp = require '../sexp'
module.exports = class Sub extends SExp
  @prefix: '-'
  evaluate: () ->
    @one.evaluate() - @two.evaluate()