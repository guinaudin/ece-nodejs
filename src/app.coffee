http = require 'http'
stylus = require 'stylus'
express = require 'express'
db = require './db'
metrics = require './metrics'

app = express()

app.set 'views', "#{__dirname}/../views"
app.set 'view engine', 'jade'
app.use express.bodyParser()
app.use express.methodOverride()
app.use express.cookieParser 'your secret here'
app.use express.session()
app.use app.router
app.use stylus.middleware "#{__dirname}/../public"
app.use express.static "#{__dirname}/../public"
app.use express.errorHandler
  showStack: true
  dumpeExceptions: true

app.get '/metric/:id.json', (req, res) ->
  console.log 'Get a metric :'
  console.log req.params.id
  metrics.get req.params.id, (err, values) ->
          return next err if err
          res.json
            id: req.params.id
            values: values

app.post '/metric/:id.json', (req, res) ->
  console.log 'Save a metric :'
  console.log req.params.id
  metrics.save req.params.id, req.body, (err) ->
          return next err if err 
          metrics.get req.params.id, (err, values) ->
            return next err if err
            res.json
              id: req.params.id
              values: values
              status: 'ok'

app.delete '/metric/:id.json', (req, res) ->
  console.log 'Delete a metric :'
  console.log req.params.id
  metrics.remove req.params.id, (err) ->
    return next err if err
    res.json 
      status: 'ok'

      http.createServer(app).listen 1234, ->
        console.log 'http://localhost:1234'

app.listen 1234