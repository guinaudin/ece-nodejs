module.exports = {
	/*
		`get(id, [options], callback)`
		--------------------------
		###Parameters
		`id`		Metric id as integer
		`callback`	Contains an err as first argument if any

		###options
		`start`: Timestamp
		`end`  : Timestamp
	*/
	get: function(id, options, callback){
		if(arguments.length === 2){
			callback = options;
		}
		setImmediate(function(){
			callback(null, [{
				timestamp: new Date('2013-11-04 14:00 UTC').getTime(),
				value: 1234
			},
			{
				timestamp: new Date('2013-11-04 14:10 UTC').getTime(),
				value: 5678
			}])
		})
	},
	/*
		`get(id, metrics, callback)`
		--------------------------
		###Parameters
		`id`		Metric id as integer
		`metrics`	Array with timestamp as keys and integer as values
		`callback`	Contains an err as first argument if any
	*/
	save: function(id, metrics, callback){}
}