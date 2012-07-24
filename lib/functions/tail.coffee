_ = require 'underscore'
module.exports = class Tail
  @prefix: "tail"
  @function: (args, context) ->
    (args[0].evaluate_with_context context).tail()