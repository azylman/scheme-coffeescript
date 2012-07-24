_ = require 'underscore'
module.exports = class Rest
  @prefix: "rest"
  @evaluate_with_context: (context) ->
    (args) ->
      (args[0].evaluate_with_context context).rest()