_ = require 'underscore'
module.exports = class Head
  @prefix: "head"
  @evaluate_with_context: (context) ->
    (args) ->
      (args[0].evaluate_with_context context).head()
    