_ = require 'underscore'
SExp = require '../sexp'
module.exports = class Call extends SExp
  @prefix: ''
  @name: "Call"
  evaluate_with_context: (context) ->
    fn = context[@values[0]]
    fn = fn.evaluate_with_context context if not _.isFunction fn
    throw new Error "#{@values[0]} is not a function" if not _.isFunction fn
    fn (@values.slice 1), context