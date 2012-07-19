SExp = require '../sexp.coffee'
module.exports = class Equals extends SExp
  @prefix: "="
  evaluate: () ->
    @one.evaluate() is @two.evaluate()