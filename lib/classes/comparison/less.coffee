SExp = require '../sexp.coffee'
module.exports = class Less extends SExp
  @prefix: "<"
  evaluate: () ->
    @one.evaluate() < @two.evaluate()