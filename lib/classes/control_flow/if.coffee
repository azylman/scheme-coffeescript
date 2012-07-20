SExp = require '../sexp'
module.exports = class If extends SExp
  @prefix: "if"
  @name: "If"
  validate: () ->
    return "if accepts 3 params, #{@values.length} were given" if @values.length isnt 3
  evaluate: () ->
    if @values[0].evaluate() then @values[1].evaluate() else @values[2].evaluate()