SExp = require '../sexp.coffee'
module.exports = class Greater extends SExp
  @prefix: ">"
  @name: "Greater"
  validate: () ->
    return "greater than accepts 2 params, #{@values.length} were given" if @values.length isnt 2
  evaluate: () ->
    @values[0].evaluate() > @values[1].evaluate()