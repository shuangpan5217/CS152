//Assume in development, tolerate this, whitespace mess
var name = "Monty";
function Rabbit(name) {
  this.name = name;
}
var r = new Rabbit("Python");

console.log(r.name); 
console.log(name);    