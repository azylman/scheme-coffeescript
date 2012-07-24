_ = require 'underscore'
module.exports = class Tail
  @prefix: "tail"
  @evaluate_with_context: (context) ->
    return (args) ->
      (args[0].evaluate_with_context context).tail()