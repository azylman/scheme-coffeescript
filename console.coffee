fs = require 'fs'
parser = ((require './interpreter') false).parser

prompt = 'schemee> '

process.stdin.resume()
process.stdin.setEncoding 'utf8'
process.stdout.write prompt

process.stdin.on 'data', (chunk) ->
  line = chunk.split '\n'
  line = line[0]
  console.log (parser line).evaluate()
  process.stdout.write prompt