SExp = require '../sexp.coffee'
module.exports = class Greater extends SExp
  @prefix: ">"
  evaluate: () ->
    @one.evaluate() > @two.evaluate()