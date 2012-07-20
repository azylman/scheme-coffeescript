SExp = require '../sexp.coffee'
module.exports = class Equals extends SExp
  @prefix: "="
  @name: "Equals"
  @num_params: 2
  evaluate: () ->
    @values[0].evaluate() is @values[1].evaluate()