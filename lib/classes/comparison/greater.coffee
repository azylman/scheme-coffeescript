SExp = require '../sexp.coffee'
module.exports = class Greater extends SExp
  @prefix: ">"
  @name: "Greater"
  @num_params: 2
  evaluate: () ->
    @one.evaluate() > @two.evaluate()