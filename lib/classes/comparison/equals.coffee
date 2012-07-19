SExp = require '../sexp.coffee'
module.exports = class Equals extends SExp
  @prefix: "="
  @name: "Equals"
  @num_params: 2
  evaluate: () ->
    @one.evaluate() is @two.evaluate()