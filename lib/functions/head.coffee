_ = require 'underscore'
module.exports = class Head
  @prefix: "head"
  @function: (args, context) ->
    (args[0].evaluate_with_context context).head()