SExp = require '../sexp'
module.exports = class If extends SExp
  @prefix: "if"
  @name: "If"
  @num_params: 3
  evaluate: () ->
    if @values[0].evaluate() then @values[1].evaluate() else @values[2].evaluate()