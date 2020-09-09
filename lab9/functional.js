var foldl = function (f, acc, array) {
	if(array.length == 0)
		return acc;
	acc = f(array.shift(), acc);
	return foldl(f, acc, array);
}

console.log(foldl(function(x,y){return x+y}, 0, [1,2,3]));
console.log(foldl(function(x,acc){return [x].concat(acc)}, [], [1,2,3]));

var foldr = function (f, z, array) {
	if(array.length == 0){
		return z;
	}
	var removeElement = array.shift()
	return f(removeElement, foldr(f, z, array));
}

console.log(foldr(function(x,y){return x/y}, 1, [2,4,8]));
console.log(foldr(function(x,acc){return [x].concat(acc)}, [], [1,2,3]));

var map = function (f, array) {
	if(array.length == 0)
		return array;
	var value = array.shift();
	return [f(value)].concat(map(f, array));
}

console.log(map(function(x){return x+x}, [1,2,3,5,7,9,11,13]));

