_ = require 'underscore'
SExp = require '../sexp'
Symbol = require '../primitive/symbol'
module.exports = class Begin extends SExp
  @prefix: 'begin'
  @name: "Begin"
  evaluate_with_context: (context) ->
    for i in _.range @values.length - 1
      @values[i].evaluate_with_context context
    @values[@values.length - 1].evaluate_with_context context