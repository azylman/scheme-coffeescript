_ = require 'underscore'
Bool = require '../types/bool'
module.exports = class And
  @prefix: "&&"
  @evaluate_with_context: (context) ->
    (args) ->
      base = (args[0].evaluate_with_context context).value()
      base = base and (args[i].evaluate_with_context context).value() for i in _.range 1, args.length
      new Bool if base then '#t' else '#f'