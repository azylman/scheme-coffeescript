_ = require 'underscore'
module.exports = class Or
  @prefix: "||"
  @function: (args, context) ->
    base = args[0].evaluate_with_context context
    base = base or (args[i].evaluate_with_context context) for i in _.range 1, args.length
    return base