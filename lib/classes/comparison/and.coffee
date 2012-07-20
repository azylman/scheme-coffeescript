SExp = require '../sexp.coffee'
module.exports = class And extends SExp
  @prefix: "&&"
  @name: "And"
  @num_params: 2
  evaluate: () ->
    @values[0].evaluate() and @values[1].evaluate()