SExp = require '../sexp.coffee'
module.exports = class NEquals
  @prefix: "/="
  @function: (args, context) ->
    (args[0].evaluate_with_context context) isnt args[1].evaluate_with_context context