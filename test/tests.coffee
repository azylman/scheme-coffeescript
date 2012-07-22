parser = (require '../lib/interpreter').parser
tokenizer = (require '../lib/interpreter').tokenizer
analyzer = (require '../lib/interpreter').analyzer
assert = require 'assert'
_ = require 'underscore'

evaluate = (sexp) ->
  (parser sexp).evaluate()

analyze = (sexp) ->
  (analyzer tokenizer sexp).toString()

tokenize = (sexp) ->
  tokenizer sexp

assert_equal = (expected, actual) ->
  assert (_.isEqual expected, actual), "is #{actual}, should be #{expected}"

describe 'parser', ->
  describe 'tokenizes', ->
    it 'non-nested statements', ->
      assert_equal [ '+', '1', '2' ], tokenize '(+ 1 2)'
      assert_equal [ '+', '1', '2', '3' ], tokenize '(+ 1 2 3)'
    it 'nested statements', ->
      assert_equal [ '+', '1', [ '+', '1', '1'] ], tokenize '(+ 1 (+ 1 1))'
      assert_equal [ '+', [ '+', '1', '1'], '1' ], tokenize '(+ (+ 1 1) 1)'
      assert_equal [ '+', [ '+', '1', '1'], [ '+', '1', '1'] ], tokenize '(+ (+ 1 1) (+ 1 1))'
      assert_equal [ '+', '1', [ '+', '1', '1', '2'], '2' ], tokenize '(+ 1 (+ 1 1 2) 2)'
    it 'multi-letter statements', ->
      assert_equal [ 'if', [ '=', '1', '2' ], '1', '2' ], tokenize '(if (= 1 2) 1 2)'
    it 'multi-digit numbers', ->
      assert_equal [ '+', '12', '2' ], tokenize '(+ 12 2)'
      assert_equal [ '+', '12', '2', '3' ], tokenize '(+ 12 2 3)'
  describe 'analyzes', ->
    it 'single digit numbers', ->
      assert_equal '[ / 1, 6 ]', analyze '(/ 1 6)'
      assert_equal '[ / 1, 6, 8 ]', analyze '(/ 1 6 8)'
    it 'multi-digit numbers', ->
      assert_equal '[ / 12, 6 ]', analyze '(/ 12 6)'
      assert_equal '[ / 12, 6, 1 ]', analyze '(/ 12 6 1)'
    it 'nested numbers', ->
      assert_equal '[ / 1, [ + 1, 3 ] ]', analyze '(/ 1 (+ 1 3))'
      assert_equal '[ / 1, [ + 1, 3 ], 1 ]', analyze '(/ 1 (+ 1 3) 1)'

describe 'interpreter', ->
  it 'does simple addition', ->
    assert_equal 3, evaluate '(+ 1 2)'
    assert_equal 5, evaluate '(+ 1 (+ 1 3))'
    assert_equal 5, evaluate '(+ (+ 1 3) 1)'
    assert_equal 8, evaluate '(+ (+ 1 3) (+ 1 3))'
  it 'does simple subtraction', ->
    assert_equal 3, evaluate '(- 1 (- 1 3))'
    assert_equal -3, evaluate '(- (- 1 3) 1)'
    assert_equal 0, evaluate '(- (- 1 3) (- 1 3))'
  it 'does simple equals comparison', ->
    assert_equal true, evaluate '(= (+ 1 1) 2)'
    assert_equal false, evaluate '(= (+ 1 1) 3)'
  it 'does simple not equals comparison', ->
    assert_equal false, evaluate '(/= (+ 1 1) 2)'
    assert_equal true, evaluate '(/= (+ 1 1) 3)'
  it 'does simple greater than comparison', ->
    assert_equal true, evaluate '(> (+ 1 2) 2)'
    assert_equal false, evaluate '(> 2 (+ 1 2))'
  it 'does simple less than comparison', ->
    assert_equal false, evaluate '(< (+ 1 2) 2)'
    assert_equal true, evaluate '(< 2 (+ 1 2))'
  it 'does simple and', ->
    assert_equal false, evaluate '(&& (= 1 2) (< 1 2))'
    assert_equal true, evaluate '(&& (= 1 1) (< 1 2))'
  it 'does simple or', ->
    assert_equal false, evaluate '(|| (= 1 2) (< 2 2))'
    assert_equal true, evaluate '(|| (= 1 1) (< 1 2))'
  it 'does simple if', ->
    assert_equal 2, evaluate '(if (= (+ 1 1) 2) 2 3)'
    assert_equal 3, evaluate '(if (= (+ 2 1) 2) 2 3)'
  it 'does simple multiplication', ->
    assert_equal 12, evaluate '(* 4 3)'
  it 'does simple division', ->
    assert_equal 2, evaluate '(/ 12 6)'
  it 'supports boolean values', ->
    assert_equal 2, evaluate '(if #t 2 3)'
    assert_equal 3, evaluate '(if #f 2 3)'
  it 'allows defining variables', ->
    assert_equal 12, evaluate '(begin (define r 3) (define s 4) (* r s))'
    assert_equal 18, evaluate '(begin (define r 3) (* r (+ r r )))'
  it 'allows setting variables', ->
    assert_equal 16, evaluate '(begin (define r 3) (set! r 4) (* r r))'