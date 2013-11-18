{exec}  = require 'child_process'
should = require 'should'
request = require 'request'
metrics = require '../lib/metrics'

describe 'HTTP REST', () ->

  it 'save and then get metric from server', (next) ->

    request.post {
      uri:'http://localhost:1234/metric/metric_3.json', 
      headers:{'content-type':'application/json'}, 
      body: JSON.stringify [
        timestamp: (new Date '2013-11-12 13:00 UTC').getTime()
        value: 101
      ,
        timestamp: (new Date '2013-11-12 13:10 UTC').getTime()
        value: 102
      ]
    }, (err, response, body) ->
      return next err if err or response.statusCode isnt 200

      metrics = JSON.parse(body).values
      metrics.length.should.eql 2
      [m1, m2] = metrics
      m1.value.should.eql 101
      m2.value.should.eql 102
      m1.timestamp.should.eql (new Date '2013-11-12 13:00 UTC').getTime()
      m2.timestamp.should.eql m1.timestamp + 10*60*1000

      request 'http://localhost:1234/metric/metric_3.json', (err, response, body) ->
        return next err if err or response.statusCode isnt 200

        metrics = JSON.parse(body).values
        metrics.length.should.eql 2
        [m1, m2] = metrics
        m1.value.should.eql 101
        m2.value.should.eql 102
        m1.timestamp.should.eql (new Date '2013-11-12 13:00 UTC').getTime()
        m2.timestamp.should.eql m1.timestamp + 10*60*1000
        next();

  it 'delete a metric on server', (next) ->

    request.post {
      uri:'http://localhost:1234/metric/metric_5.json', 
      headers:{'content-type':'application/json'}, 
      body: JSON.stringify [
        timestamp: (new Date '2013-11-14 12:00 UTC').getTime()
        value: 103
      ,
        timestamp: (new Date '2013-11-14 12:10 UTC').getTime()
        value: 104
      ]
    }, (err, response, body) ->
      return next err if err or response.statusCode isnt 200

      request.del uri:'http://localhost:1234/metric/metric_5.json', (err, response, body) ->
        return next err if err or response.statusCode isnt 200

        status = JSON.parse(body).status
        status.should.eql "ok"
        next();