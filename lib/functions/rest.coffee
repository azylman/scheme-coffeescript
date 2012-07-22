_ = require 'underscore'
module.exports = class Rest
  @prefix: "rest"
  @function: (args, context) ->
    _.rest args[0].evaluate_with_context context