fs = require 'fs'
parser = ((require './interpreter') false).parser

prompt = 'schemee> '

if process.argv.length > 2
  filename = process.argv[2]

  data = fs.readFileSync filename, "utf8"
  context = {}
  start = Date.now()
  for line in data.split '\n'
    result = (parser line).evaluate_with_default_context context
    console.log result.value() if result? and result isnt ""
  end = Date.now()
  return console.log "Running time: #{end - start} ms"

process.stdin.resume()
process.stdin.setEncoding 'utf8'
process.stdout.write prompt

process.stdin.on 'data', (line) ->
  line = (line.split '\n')[0]
  console.log (parser line).evaluate().value()
  process.stdout.write prompt