var should = require('should');
var metrics = require('../lib/metrics');

//creation d'un groupe
describe("metrics", function(){
	//test
	it("get a metric", function(next){
		metrics.get('me', function(err, metrics){
			if(err){ return next(err); };
			metrics.length.should.be.above(1);
			metrics[1].timestamp.should.eql(
				metrics[0].timestamp + 10*60*1000
			);
			next();
		})
	});
});