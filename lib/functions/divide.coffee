_ = require 'underscore'
module.exports = class Divide
  @prefix: "/"
  @function: (args, context) ->
    base = args[0].evaluate_with_context context
    base /= (args[i].evaluate_with_context context) for i in _.range 1, args.length
    return base