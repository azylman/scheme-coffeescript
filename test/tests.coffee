parser = (require '../lib/scheme-parser').parser
tokenizer = (require '../lib/scheme-parser').tokenizer
analyzer = (require '../lib/scheme-parser').analyzer
assert = require 'assert'
_ = require 'underscore'

evaluate = (sexp) ->
  (parser sexp).evaluate()

analyze = (sexp) ->
  (analyzer tokenizer sexp).toString()

tokenize = (sexp) ->
  tokenizer sexp

assert_equal = (left, right) ->
  assert (_.isEqual left, right), "is #{left}, should be #{right}"

describe 'parser', ->
  describe 'tokenizes', ->
    it 'non-nested statements', ->
      assert_equal (tokenize '(+ 1 2)'), [ '+', '1', '2' ]
    it 'nested statements', ->
      assert_equal (tokenize '(+ 1 (+ 1 1))'), [ '+', '1', [ '+', '1', '1'] ]
      assert_equal (tokenize '(+ (+ 1 1) 1)'), [ '+', [ '+', '1', '1'], '1' ]
      assert_equal (tokenize '(+ (+ 1 1) (+ 1 1))'), [ '+', [ '+', '1', '1'], [ '+', '1', '1'] ]
    it 'multi-letter statements', ->
      assert_equal (tokenize '(if (= 1 2) 1 2)'), [ 'if', [ '=', '1', '2' ], '1', '2' ]
    it 'multi-digit numbers', ->
      assert_equal (tokenize '(+ 12 2)'), [ '+', '12', '2' ]
  describe 'analyzes', ->
    it 'single digit numbers', ->
      assert_equal (analyze '(/ 1 6)'), '[ / 1, 6 ]'
    it 'multi-digit numbers', ->
      assert_equal (analyze '(/ 12 6)'), '[ / 12, 6 ]'
    it 'nested numbers', ->
      assert_equal (analyze '(/ 1 (+ 1 3))'), '[ / 1, [ + 1, 3 ] ]'

describe 'interpreter', ->
  it 'does simple addition', ->
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
  it 'does simple greater than comparison', ->
    assert_equal true, evaluate '(> (+ 1 2) 2)'
    assert_equal false, evaluate '(> 2 (+ 1 2))'
  it 'does simple less than comparison', ->
    assert_equal false, evaluate '(< (+ 1 2) 2)'
    assert_equal true, evaluate '(< 2 (+ 1 2))'
  it 'does simple if', ->
    assert_equal 2, evaluate '(if (= (+ 1 1) 2) 2 3)'
    assert_equal 3, evaluate '(if (= (+ 2 1) 2) 2 3)'
  it 'does simple multiplication', ->
    assert_equal 12, evaluate '(* 4 3)'
  it 'does simple division', ->
    assert_equal 2, evaluate '(/ 12 6)'