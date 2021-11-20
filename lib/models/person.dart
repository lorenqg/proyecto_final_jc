class Person {
  String? id;
  String? name;
  String? lastName;
  String? direction;
  String? birthdate;
  String? salary;
  String? date;

  Person({this.id,
    this.name,
    this.lastName,
    this.direction,
    this.birthdate,
    this.salary,
    this.date,
  });

  Person.fromJson(Map<String, dynamic> jsonPerson) {
    id = jsonPerson['id'];
    name = jsonPerson['name'];
    lastName = jsonPerson['lastName'];
    direction = jsonPerson['direction'];
    birthdate = jsonPerson['birthdate'];
    salary = jsonPerson['salary'];
    date = jsonPerson['date'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['adress'] = this.direction;
    data['birthdate'] = this.birthdate;
    data['salary'] = this.salary;
    data['date'] = this.date;
    return data;
  }
}