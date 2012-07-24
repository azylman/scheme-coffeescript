Scheme interpreter in CoffeeScript
=======
This will eventually be an R5RS-conformant Scheme interpreter, written in CoffeeScript.

There are two main parts: `console.coffee` and `interpreter.coffee`. You can run an interactive console with the command `coffee console.coffee` or, alternatively, execute a script by running `coffee console.coffee /path/to/script`.

`interpreter.coffee` serves as a library for the console - it contains all of the parts necessasry for interpretation, specifically a tokenizer and a syntactic analyzer.

## Example
Here is an example block of code that you can execute:

    (define
      fib
      (lambda
        (n)
        (if (= n 0)
          0
          (fib2 n 0 1))))
    (define
      fib2
      (lambda
        (n p0 p1)
        (if (= n 1)
          p1
          (fib2 (- n 1) p1 (+ p0 p1)))))
    (fib 1200)

This evaluats to `2.7269884455406272e+250`, the 1200th number in the Fibonnaci sequence.

## Supported types
  * numbers
  * lists
  * symbols

## Supported functions
  * +
  * -
  * &&
  * ||
  * *
  * /
  * =
  * /=
  * \>
  * <
  * head
  * rest
  * tail
  * length
