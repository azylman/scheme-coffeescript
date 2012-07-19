_ = require 'underscore'
fs = require 'fs'

classes = {}
prefixes = {}

root = "#{__dirname}/classes"
folders = fs.readdirSync root
for folder in _.difference folders, ['sexp.coffee']
  _classes = fs.readdirSync "#{root}/#{folder}"
  for _class in _classes
    loaded_class = require "#{root}/#{folder}/#{_class}"
    classes[loaded_class.name] = loaded_class
    prefixes[loaded_class.prefix] = loaded_class

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
  _class = prefixes[tokens[0]]
  if not _class?
    if isNumeric tokens[0]
      return new classes.Number tokens[0]
    else
      return console.log "Undefined type #{tokens[0]}"
  switch _class.num_params
    when 1
      return new _class (analyze tokens[1])
    when 2
      return new _class (analyze tokens[1]), (analyze tokens[2])
    when 3
      return new _class (analyze tokens[1]), (analyze tokens[2]), (analyze tokens[3])


isNumeric = (string) ->
  return not isNaN string

module.exports.tokenize = tokenize
module.exports.parser = parser