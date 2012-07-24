_ = require 'underscore'
Number = require '../types/number'
module.exports = class Length
  @prefix: "length"
  @evaluate_with_context: (context) ->
    (args) ->
      new Number (args[0].evaluate_with_context context).length().toString()