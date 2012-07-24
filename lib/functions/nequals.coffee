SExp = require '../sexp.coffee'
Bool = require '../types/bool'
module.exports = class NEquals
  @prefix: "/="
  @evaluate_with_context: (context) ->
    (args) ->
      res1 = (args[0].evaluate_with_context context).value()
      res2 = (args[1].evaluate_with_context context).value()
      result = res1 isnt res2
      new Bool if result then '#t' else '#f'