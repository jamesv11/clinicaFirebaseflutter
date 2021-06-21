class Patient {
  final String id;
  final String email;
  final String photo;
  final String name;
  final String lastName;
  final DateTime birthdate;
  final int age;
  final String address;
  final String neighborhood;
  final String phoneNumber;
  final String city;
  final bool state;

  Patient(
      {this.id,
      this.email,
      this.photo,
      this.name,
      this.lastName,
      this.birthdate,
      this.age,
      this.address,
      this.neighborhood,
      this.phoneNumber,
      this.city,
      this.state});

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
        id: json['id'],
        email: json['email'],
        photo: json['photo'],
        name: json['name'],
        lastName: json['lastName'],
        birthdate: json['birthdate'],
        age: json['age'],
        address: json['address'],
        neighborhood: json['neighborhood'],
        phoneNumber: json['phoneNumber'],
        city: json['city'],
        state: json['state']);
  }
}
