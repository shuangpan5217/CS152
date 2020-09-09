export {};
var name: string = "Monty";

class Rabbit{
  name: string;
  constructor(name: string){
  	this.name = name;
  }
}
var r = new Rabbit("Python");

console.log(r.name);  
console.log(name);   
