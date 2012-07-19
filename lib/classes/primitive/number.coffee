SExp = require '../sexp'
module.exports = class Number extends SExp
  @prefix: ""
  evaluate: () ->
    +@one