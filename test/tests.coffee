parser = (require '../lib/scheme-parser').parser
tokenize = (require '../lib/scheme-parser').tokenize
assert = require 'assert'
_ = require 'underscore'

evaluate = (sexp) ->
  (parser sexp).evaluate()

describe 'parser', ->
  describe 'tokenizes', ->
    it 'non-nested statement', ->
      assert _.isEqual (tokenize '(+ 1 2)'), [ '+', '1', '2' ]
    it 'nested statements', ->
      assert _.isEqual (tokenize '(+ 1 (+ 1 1))'), [ '+', '1', [ '+', '1', '1'] ]
      assert _.isEqual (tokenize '(+ (+ 1 1) 1)'), [ '+', [ '+', '1', '1'], '1' ]
      assert _.isEqual (tokenize '(+ (+ 1 1) (+ 1 1))'), [ '+', [ '+', '1', '1'], [ '+', '1', '1'] ]
    it 'multi-letter statements', ->
      assert _.isEqual (tokenize '(if (= 1 2) 1 2)'), [ 'if', [ '=', '1', '2' ], '1', '2' ]

describe 'interpreter', ->
  it 'does simple addition', ->
    assert.equal 5, evaluate '(+ 1 (+ 1 3))'
    assert.equal 5, evaluate '(+ (+ 1 3) 1)'
    assert.equal 8, evaluate '(+ (+ 1 3) (+ 1 3))'
  it 'does simple subtraction', ->
    assert.equal 3, evaluate '(- 1 (- 1 3))'
    assert.equal -3, evaluate '(- (- 1 3) 1)'
    assert.equal 0, evaluate '(- (- 1 3) (- 1 3))'
  it 'does simple equals comparison', ->
    assert.equal true, evaluate '(= (+ 1 1) 2)'
    assert.equal false, evaluate '(= (+ 1 1) 3)'
  it 'does a simple greater than comparison', ->
    assert.equal true, evaluate '(> (+ 1 2) 2)'
    assert.equal false, evaluate '(> 2 (+ 1 2))'
  it 'does a simple less than comparison', ->
    assert.equal false, evaluate '(< (+ 1 2) 2)'
    assert.equal true, evaluate '(< 2 (+ 1 2))'
  it 'does a simple if', ->
    assert.equal 2, evaluate '(if (= (+ 1 1) 2) 2 3)'
    assert.equal 3, evaluate '(if (= (+ 2 1) 2) 2 3)'