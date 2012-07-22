_ = require 'underscore'
SExp = require '../sexp'
Symbol = require '../primitive/symbol'
module.exports = class Proc extends SExp
  @prefix: ''
  @name: "Proc"
  evaluate_with_context: (context) ->
    fn = context[@values[0]]
    throw new Error "#{@values[0]} is not a function" if not _.isFunction fn
    fn @values.slice 1