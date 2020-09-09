/*
	MDN web docs as reference for all functions
*/

function add(a, b){
	return a + " " + b;
}

let proxyHandler = {
	has: function(target, key) {
		console.log(key + ' in ' + 'current target' + ': ' + (key in target));
		return key in target;
	},
	get: function(target, prop, receiver) {
		if(prop === 'first_name'){
			console.log('Found first name: ' + target.first_name);
			return target.first_name;
		}else{
			console.log('Not Found first name. Return the current value: ' + Reflect.get(...arguments));
			return Reflect.get(...arguments);
		}
	},
	set: function(target, prop, value, receiver) {
		console.log("Set " + value + ' to ' + prop);
		target[prop] = value;
		return true;
	},
	deleteProperty: function(target, property) {
		if(property in target){
			delete target[property];
			console.log('delete successfully!');
			return true;
		}else{
			console.log('Fail to delete!');
			return false;
		}
	},
	apply: function(target, thisArg, argumentsList) {
		console.log('Add ' + argumentsList[0] + ' and ' + argumentsList[1]);
		return argumentsList[0] + " " + argumentsList[1];
	},
	construct: function(target, argumentsList, newTarget) {
		console.log('The constructor is called!');
		return new target(...argumentsList);
	},
	getOwnPropertyDescriptor: function(target, prop) {
		console.log('Called: ' + prop + ': ' + target[prop]);
		return {configurable: true, enumerable: true, value: 5}
	},
	getPrototypeOf: function(target) {
		console.log('Return prototype of the current target.');
		return personPrototype;
	},
	setPrototypeOf: function(target, prototype) {
		console.log('Unable to change the prototype.');
		target.first_name = 'jialiang';
		return false;
	},
	isExtensible: function(target) {
		console.log('Check extensibility.');
		return Reflect.isExtensible(target);
	},
	preventExtensions: function(target) {
		console.log('Prevent extensions.');
		return Reflect.preventExtensions(target);
	},
	defineProperty: function(target, property, descriptor) {
		console.log(descriptor);
    	return Reflect.defineProperty(target, property, descriptor);
	},
	ownKeys: function(target) {
		console.log('return an enumerable object.');
		return Reflect.ownKeys(target);
	}
}

let person = {
	first_name: 'Shuang',
	last_name: 'Pan',
	height: 175,
	weight: 59,
	hobby: 'programming',
	type: 'nothing'
};

let personPrototype = {
	first_name: 'Shuang',
	last_name: 'Pan',
	height: 175,
	weight: 59,
	hobby: 'chess'
}

function name(first_name){
	this.first_name = first_name;
}

function trace(obj){
	return new Proxy(obj, proxyHandler);
}

function startOperation(proxyObj){
	let testApply = new Proxy(add, proxyHandler);
	let testConstruct = new Proxy(name, proxyHandler);
	console.log('first_name in proxyObj: ' + ('first_name' in proxyObj));
	console.log('birthday in proxyObj: ' + ('birthday' in proxyObj));
	console.log('First Name: ' + proxyObj.first_name); 
	console.log('Weight: ' + proxyObj.weight); 
	console.log('Gender in person: ' + ('gender' in proxyObj));
	proxyObj.gender = 'male';
	console.log('Gender in person: ' + ('gender' in proxyObj));
	let deleteResult = delete proxyObj.gender;
	console.log('Delete successfully: ' + deleteResult);
	let deleteResult1 = delete proxyObj.gender;
	console.log('Delete successfully: ' + deleteResult1);
	console.log('Full Name: ' + testApply(proxyObj.first_name, proxyObj.last_name));
	console.log(new testConstruct('XinXin').first_name);
	console.log(Object.getOwnPropertyDescriptor(proxyObj, 'first_name').value);
	console.log(Object.getPrototypeOf(proxyObj) === personPrototype);
	console.log(Object.getPrototypeOf(proxyObj).hobby);
	console.log(Reflect.setPrototypeOf(proxyObj, personPrototype));
	console.log(proxyObj.first_name);
	console.log(Object.isExtensible(proxyObj));
	Object.preventExtensions(proxyObj);
	console.log(Object.isExtensible(proxyObj));
	Object.defineProperty(proxyObj, 'type', {
  		value: 'proxy',
  		type: 'custom'
	});
	for(let key of Object.keys(proxyObj)){
		console.log(key);
	}
}
startOperation(trace(person));