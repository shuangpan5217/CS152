function makeListOfAdders(lst){
	var arr = [];
	for(var i = 0; i < lst.length; i++){
		arr.push(function(y){
			return lst[i] + y;
		});
	}
	return arr;
}

a = makeListOfAdders([1, 5]);
console.log(a[0](42)); // 43
console.log(a[1](42)); // 47

function makeObject () {
return {
	madeBy: 'Austin Tech. Sys.'
	}
}

var o = makeObject();
console.log(o.madeBy); 