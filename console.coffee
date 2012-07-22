fs = require 'fs'
parser = ((require './interpreter') true).parser

if process.argv.length < 3
  prompt = 'schemee> '

  process.stdin.resume()
  process.stdin.setEncoding 'utf8'
  process.stdout.write prompt

  process.stdin.on 'data', (chunk) ->
    line = chunk.split '\n'
    line = line[0]
    console.log (parser line).evaluate()
    process.stdout.write prompt
else
  filename = process.argv[2]

  data = fs.readFileSync filename, "utf8"
  context = {}
  for line in data.split '\n'
    result = (parser line).evaluate_with_default_context context
    console.log result if result?