_ = require 'underscore'
module.exports = class Tail
  @prefix: "tail"
  @function: (args, context) ->
    array = (args[0].evaluate_with_context context)
    array[array.length - 1]