_ = require 'underscore'
fs = require 'fs'

builtins = {}
prefixes = {}
types = {}
context = {}
root = "#{__dirname}/lib"

process_all_modules = (path, process) ->
  filenamess = fs.readdirSync "#{root}/#{path}"
  for filename in filenamess
    process require "#{root}/#{path}/#{filename}"

process_all_modules 'builtin', (_module) ->
  builtins[_module.name] = _module
  prefixes[_module.prefix] = _module

process_all_modules 'types', (_module) ->
  types[_module.name] = _module

process_all_modules 'functions', (_module) ->
  context[_module.prefix] = _module.function

parse = (string, debug=false) ->
  tokens = tokenize string, debug
  console.log "Tokens:", tokens if debug
  result = analyze tokens, debug
  console.log "Analyzed tokens:", result.toString() if debug
  result

separate = (string, debug=false) ->
  modded_string = ""
  skip = 0
  for character in string
    # Special handling to turn arrays from '(4 5 6) to ( ' 4 5 6 ) to make it easier to parse
    if skip > 0
      skip--
      continue
    if character is "'"
      modded_string += "( ' "
      skip = 1
      continue
    modded_string += " " if character is ')'
    modded_string += character
    modded_string += " " if character is '('
  return modded_string.split ' '

tokenize = (string, debug=false) ->
  array = separate string, debug
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

analyze = (tokens, debug=false) ->
  # If our first token is an apostrophre it signals that an array is coming
  return analyze_array tokens.slice 1 if tokens[0] is "'"

  # If it's not an array type and not an array, it's a type
  if not _.isArray tokens
    for name, type of types
      if type.is tokens
        return new type tokens
    return throw new Error "undefined type #{tokens}"
  _class = prefixes[tokens[0]]
  # if it's not an array and it isn't a builtin prefix, that means we're calling a function
  # that's defined elsewhere - either a lambda or from the standard library
  _class = builtins.Call if not _class
  tokens = tokens.slice 1 if _class isnt builtins.Call
  return new _class (_.map tokens, (token) -> analyze token, debug), context

analyze_array = (tokens, debug=false) ->
  return new types.List _.map tokens, (token) -> analyze token, debug

isNumeric = (string) ->
  return not isNaN string

module.exports = (debug=false) ->
  analyzer: (tokens) -> analyze tokens, debug
  tokenizer: (string) -> tokenize string, debug
  parser: (string) -> parse string, debug