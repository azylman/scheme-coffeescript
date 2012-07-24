_ = require 'underscore'
SExp = require '../sexp'
module.exports = class List extends SExp
  @prefix: ""
  @name: "List"
  @is: (string) ->
    return false
  evaluate_with_context: (context) ->
    res = _.map @values, (value) -> value.evaluate_with_context context
    new List res
  value: () ->
    _.map @values, (value) -> value.value()
  rest: () ->
    new List @values.slice 1, @values.length
  length: () ->
    @values.length
  head: () ->
    @values[0]
  tail: () ->
    @values[@values.length - 1]