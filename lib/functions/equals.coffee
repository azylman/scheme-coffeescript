_ = require 'underscore'
module.exports = class Equals
  @prefix: "="
  @function: (args, context) ->
    return (args[0].evaluate_with_context context) is args[1].evaluate_with_context context