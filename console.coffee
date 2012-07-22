fs = require 'fs'
parser = ((require './interpreter') false).parser

process.stdin.resume()
process.stdin.setEncoding 'utf8'

process.stdin.on 'data', (chunk) ->
  line = chunk.split '\n'
  line = line[0]
  console.log (parser line).evaluate()