re = require('request-enhanced')

re.get 'http://www.example.com', (error, data) ->
  console.log "Fetched: #{data.length} characters"

re.get 'http://www.example.com', "#{__dirname}/test.txt", (error, data) ->
  console.log 'Fetched:', data

regex = 
  firstLink: 
    regex: /<a href="(.*?)">(.*?)<\/a>/i
    results:
      0: 'html'
      1: 'href'
      2: 'text'
  allLinks: 
    regex: /<a href="(.*?)">(.*?)<\/a>/gi
    results:
      0: 'html'
      1: 'href'
      2: 'text'

re.get 'http://www.example.com', regex, (error, data, results) ->
  console.log "Fetched: #{data.length} characters to find:"
  console.log results