_ = require 'underscore'
module.exports = class Rest
  @prefix: "rest"
  @function: (args, context) ->
    (args[0].evaluate_with_context context).rest()