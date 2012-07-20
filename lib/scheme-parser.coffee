_ = require 'underscore'
fs = require 'fs'

root = "#{__dirname}/classes"

classes = {}
prefixes = {}
folders = fs.readdirSync root
for folder in _.difference folders, ['sexp.coffee']
  _classes = fs.readdirSync "#{root}/#{folder}"
  classes[folder] = {}
  for _class in _classes
    loaded_class = require "#{root}/#{folder}/#{_class}"
    classes[folder][loaded_class.name] = loaded_class
    prefixes[loaded_class.prefix] = loaded_class

primitive = classes.primitive

parse = (string, debug=false) ->
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
  throw new Error "malformed string" if array[0] isnt '(' and array[array.length-1] isnt ')'
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
  if not _.isArray tokens
    if isNumeric tokens
      return new primitive.Number tokens
    else
      return throw new Error "undefined primitive #{tokens}"
  _class = prefixes[tokens[0]]
  return throw new Error "prefix #{tokens[0]} is invalid" if not _class?
  tokens = tokens.slice 1
  return new _class _.map tokens, (token) -> analyze token

isNumeric = (string) ->
  return not isNaN string

module.exports.analyzer = analyze
module.exports.tokenizer = tokenize
module.exports.parser = parse
