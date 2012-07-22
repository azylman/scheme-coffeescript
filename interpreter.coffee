_ = require 'underscore'
fs = require 'fs'

builtins = {}
prefixes = {}
primitives = {}
context = {}
root = "#{__dirname}/lib"

process_all_modules = (path, process) ->
  filenamess = fs.readdirSync "#{root}/#{path}"
  for filename in filenamess
    process require "#{root}/#{path}/#{filename}"

process_all_modules 'builtin', (_module) ->
  builtins[_module.name] = _module
  prefixes[_module.prefix] = _module

process_all_modules 'primitive', (_module) ->
  primitives[_module.name] = _module

process_all_modules 'functions', (_module) ->
  context[_module.prefix] = _module.function

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
    for name, primitive of primitives
      if primitive.is tokens
        return new primitive tokens
    return throw new Error "undefined primitive #{tokens}"
  _class = prefixes[tokens[0]]
  # if it's not an array and it isn't a prefix, that means we're calling a function that's defined elsewhere
  # - either a lambda or from the standard library
  return new builtins.Call (_.map tokens, (token) -> analyze token), context if not _class?
  tokens = tokens.slice 1
  return new _class (_.map tokens, (token) -> analyze token), context

isNumeric = (string) ->
  return not isNaN string

module.exports.analyzer = analyze
module.exports.tokenizer = tokenize
module.exports.parser = parse
