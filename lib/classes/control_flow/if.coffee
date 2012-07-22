SExp = require '../sexp'
module.exports = class If extends SExp
  @prefix: "if"
  @name: "If"
  validate: () ->
    return "if accepts 3 params, #{@values.length} were given" if @values.length isnt 3
  evaluate_with_context: (context) ->
    if @values[0].evaluate_with_context context
      @values[1].evaluate_with_context context
    else
      @values[2].evaluate_with_context context