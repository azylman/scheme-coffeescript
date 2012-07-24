_ = require 'underscore'
SExp = require '../sexp'
module.exports = class Lambda extends SExp
  @prefix: 'lambda'
  @name: "Lambda"
  validate: () ->
    return "only accepts two arguments" if @values.length isnt 2
  evaluate_with_context: (context) ->
    (args) =>
      # I'm not sure why we need to refer to @values[0].values here instead of just @values[0]
      # I'm pretty sure that the args are being created as a call since the lambda parsing
      # is also recursive - probably should change at some point, but fine for now
      throw new Error "Invalid number of arguments" if args.length isnt @values[0].values.length
      new_context = {}
      new_context[@values[0].values[i]] = args[i] for i in _.range args.length
      extend_context = _.extend new_context, context
      @values[1].evaluate_with_context extend_context