_ = require 'underscore'
module.exports = class And
  @prefix: "&&"
  @function: (args, context) ->
    base = args[0].evaluate_with_context context
    base = base and (args[i].evaluate_with_context context) for i in _.range 1, args.length
    return base