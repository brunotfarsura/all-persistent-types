class Person {
  int? id;
  final String firstName;
  final String lastName;
  final String address;

  Person(this.id, this.firstName, this.lastName, this.address);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'address': address,
    };
  }
}