SExp = require '../sexp.coffee'
module.exports = class Less extends SExp
  @prefix: "<"
  @name: "Less"
  validate: () ->
    return "less than accepts 2 params, #{@values.length} were given" if @values.length isnt 2
  evaluate_with_context: (context) ->
    (@values[0].evaluate_with_context context) < @values[1].evaluate_with_context context