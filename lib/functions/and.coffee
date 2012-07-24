_ = require 'underscore'
Bool = require '../types/bool'
module.exports = class And
  @prefix: "&&"
  @function: (args, context) ->
    base = (args[0].evaluate_with_context context).value()
    base = base and (args[i].evaluate_with_context context).value() for i in _.range 1, args.length
    return new Bool if base then '#t' else '#f'