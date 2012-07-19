SExp = require '../sexp'
module.exports = class Add extends SExp
  @prefix: "+"
  @name: "Add"
  @num_params: 2
  evaluate: () ->
    @one.evaluate() + @two.evaluate()