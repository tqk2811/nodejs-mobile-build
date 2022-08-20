import http from 'http';

const options = {
	hostname: 'ip-api.com',
	port: 80,
	path: '/json',
	method: 'GET',
};

console.log("test nodejs");

testAsync();

async function testAsync() {
	await FuncPromise();
	console.log("await success");
}

function FuncPromise() {	
	return new Promise(function (resolve, reject) {
		const req = http.request(options, res => {
			console.log(`statusCode: ${res.statusCode}`);
			res.on('data', d => {
				console.log(`data: ${d}`);	
				resolve(d);
			});	
		});		
		req.on('error', error => {
			console.log(`error: ${error}`);	
			resolve(error);
		});
		req.end();
	});
}
