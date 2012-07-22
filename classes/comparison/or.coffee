_ = require 'underscore'
SExp = require '../sexp.coffee'
module.exports = class Or extends SExp
  @prefix: "||"
  @name: "Or"
  evaluate_with_context: (context) ->
    base = @values[0].evaluate_with_context context
    base = base or (@values[i].evaluate_with_context context) for i in _.range 1, @values.length
    return base