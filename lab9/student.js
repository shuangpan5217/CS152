function Student(firstName, lastName, studentID){
	this.firstName = firstName;
	this.lastName = lastName;
	this.studentID = studentID;
	this.display = function(){console.log("First Name: " + this.firstName + ".\n" + 
										  "Last Name: " + this.lastName + ".\n" +
										  "Student ID: " + this.studentID + ".\n")};
}

var student1 = new Student("Shuang", "Pan", 123456789);
var student2 = new Student("Wei", "Xiang", 111111111);
var student3 = new Student("Liang", "Jia", 222222222);
var student4 = new Student("Chen", "Shi", 333333333);
var students = [student1, student2, student3, student4];

students[0].graduated = false;

var student5 = {
	firstName: "Jing",
	lastName: "Xu",
	studentID: 444444444,
	__proto__: new Student};
students.push(student5);

console.log(students.length);
for(var i = 0; i < students.length; i++){
	students[i].display();
}

console.log(students);