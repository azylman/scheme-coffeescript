SExp = require '../sexp.coffee'
module.exports = class NEquals extends SExp
  @prefix: "/="
  @name: "ENquals"
  @num_params: 2
  evaluate: () ->
    @values[0].evaluate() isnt @values[1].evaluate()