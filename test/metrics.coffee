{exec} = require 'child_process'
should = require 'should'
metrics = require '../lib/metrics'

describe "metrics", () ->

metrics = null

before (next) ->
	exec "rm -rf #{__dirname}/../db/test", (err, stdout) ->
		next err

it "get a metric", (next) ->
metrics.get 'metric_1', (err, metrics) ->
  return next err if err
  metrics.length.should.eql 2
  [m1, m2] = metrics
  m1.timestamp.should.eql (new Date '2013-11-04 14:00 UTC').getTime()
  m1.value.should.eql 1234
  m2.timestamp.should.eql m1.timestamp + 10*60*1000
  next()


it "get a metric", (next) ->
  metrics.save 'metric_1', [
  	(new Timestamp '2013-11-04 14:00 UTC').getTime(),
	(new Timestamp '2013-11-04 14:10 UTC').getTime()
	], (err) ->
  next err if err
  return next err if err