_ = require 'underscore'
module.exports = class Length
  @prefix: "length"
  @function: (args, context) ->
    _.size args[0].evaluate_with_context context