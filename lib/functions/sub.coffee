_ = require 'underscore'
Number = require '../types/number'
module.exports = class Sub
  @prefix: '-'
  @evaluate_with_context: (context) ->
    (args) ->
      base = (args[0].evaluate_with_context context).value()
      base -= (args[i].evaluate_with_context context).value() for i in _.range 1, args.length
      new Number base.toString()