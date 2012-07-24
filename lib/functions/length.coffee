_ = require 'underscore'
Number = require '../types/number'
module.exports = class Length
  @prefix: "length"
  @function: (args, context) ->
    new Number (args[0].evaluate_with_context context).length().toString()