parser = (require './scheme-parser').parser

simple_math = '(+ 1 (+ 1 3))'
simple_evaluation = '(= (+ 1 1) 2)'
simple_if = '(if (= (+ 1 1) 2) 2 3)'
sexp = parser simple_if

console.log sexp.evaluate()