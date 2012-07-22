_ = require 'underscore'
SExp = require '../sexp'
module.exports = class List extends SExp
  @prefix: ""
  @name: "List"
  @is: (string) ->
    return false
  evaluate_with_context: (context) ->
    return _.map @values, (value) -> value.evaluate_with_context context