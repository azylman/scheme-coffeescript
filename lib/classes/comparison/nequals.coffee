SExp = require '../sexp.coffee'
module.exports = class NEquals extends SExp
  @prefix: "/="
  @name: "NEquals"
  validate: () ->
    return "not equals accepts 2 params, #{@values.length} were given" if @values.length isnt 2
  evaluate: () ->
    @values[0].evaluate() isnt @values[1].evaluate()