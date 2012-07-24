_ = require 'underscore'
SExp = require '../sexp'
module.exports = class Call extends SExp
  @prefix: ''
  @name: "Call"
  evaluate_with_context: (context) ->
    fn = context[@values[0]]
    throw new Error "#{@values[0]} is not a function" if not fn?
    fn = fn.evaluate_with_context context
    throw new Error "#{@values[0]} is not a function" if not _.isFunction fn
    args = (_.map (@values.slice 1), (value) -> value.evaluate_with_context context)
    fn args, context
  toString: () ->
    result = "[ "
    result += @values[0]
    result += " #{@values[i].toString()}," for i in _.range 1, @values.length
    result = result.substring 0, result.length - 1
    result += " ]"
    result