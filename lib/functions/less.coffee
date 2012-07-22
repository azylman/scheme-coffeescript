module.exports = class Less
  @prefix: "<"
  @function: (args, context) ->
    (args[0].evaluate_with_context context) < args[1].evaluate_with_context context