_ = require 'underscore'

SExp = require '../sexp'
module.exports = class Add extends SExp
  @prefix: "+"
  @name: "Add"
  evaluate_with_context: (context) ->
    (args) ->
      base = args[0].evaluate_with_context context
      base += (args[i].evaluate_with_context context) for i in _.range 1, args.length
      return base