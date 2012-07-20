SExp = require '../sexp'
module.exports = class Number extends SExp
  @prefix: ""
  @name: "Number"
  @num_params: 1
  evaluate: () ->
    +@values