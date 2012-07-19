_ = require 'underscore'

# TODO: Load classes in a better way
load = (type, names) ->
  result = {}
  for name in names
    result[name] = require "./classes/#{type}/#{name.toLowerCase()}"
  result

primitive = load 'primitive', ['Number']
func = load 'function', ['Add', 'Sub']
comp = load 'comparison', ['Equals', 'Greater', 'Less']
control = load 'control_flow', ['If']

parser = (string, debug=false) ->
  tokens = tokenize string
  console.log "Tokens:", tokens if debug
  result = analyze tokens
  console.log "Analyzed tokens:", result.toString() if debug
  result

separate = (string) ->
  modded_string = ""
  for character in string
    modded_string += " " if character is ')'
    modded_string += character
    modded_string += " " if character is '('
  return modded_string.split ' '

tokenize = (string) ->
  array = separate string
  throw "Malformed string" if array[0] isnt '(' and array[array.length-1] isnt ')'
  [result, rest] = tokenize_part array.slice 1, array.length
  return result

tokenize_part = (array) ->
  out = []
  i = 0
  len = array.length
  while i < len
    if array[i] is '('
      [array, rest] = tokenize_part array.slice i+1
      out.push array
      array = rest
      i = 0
      len = array.length
      continue
    if array[i] is ')'
      return [out, array.slice i+1, array.length]
    out.push array[i]
    i++
  return [array, []]

analyze = (tokens) ->
  switch tokens[0]
    when "+"
      new func.Add (analyze tokens[1]), (analyze tokens[2])
    when "-"
      new func.Sub (analyze tokens[1]), (analyze tokens[2])
    when "="
      new comp.Equals (analyze tokens[1]), (analyze tokens[2])
    when ">"
      new comp.Greater (analyze tokens[1]), (analyze tokens[2])
    when "<"
      new comp.Less (analyze tokens[1]), (analyze tokens[2])
    when "if"
      new control.If (analyze tokens[1]), (analyze tokens[2]), (analyze tokens[3])
    else
      if isNumeric tokens[0]
        return new primitive.Number tokens[0]
      else
        console.log "Undefined type #{tokens[0]}"

isNumeric = (string) ->
  return not isNaN string

module.exports.tokenize = tokenize
module.exports.parser = parser