_ = require 'underscore'
SExp = require '../sexp'
module.exports = class Bool extends SExp
  @prefix: ""
  @name: "Bool"
  validate: () ->
    return "#{@values} isn't a boolean" if not @constructor.is @values
  @is: (string) ->
    (not _.isArray string) and string.length is 2 and string[0] is '#'
  evaluate_with_context: (context) ->
    @values is '#t'