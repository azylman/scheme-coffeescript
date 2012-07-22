_ = require 'underscore'
SExp = require '../sexp.coffee'
module.exports = class And extends SExp
  @prefix: "&&"
  @name: "And"
  evaluate_with_context: (context) ->
    base = @values[0].evaluate_with_context context
    base = base and (@values[i].evaluate_with_context context) for i in _.range 1, @values.length
    return base