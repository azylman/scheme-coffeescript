_ = require 'underscore'
SExp = require '../sexp.coffee'
module.exports = class Or extends SExp
  @prefix: "||"
  @name: "Or"
  evaluate: () ->
    base = @values[0].evaluate()
    base = base or @values[i].evaluate() for i in _.range 1, @values.length
    return base