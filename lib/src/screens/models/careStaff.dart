class CareStaff {
  final String email;
  final String id;
  final String photo;
  final String name;
  final String lastName;
  final String job;
  final bool state;
  final bool turn;
  final String password;

  CareStaff(
      {this.email,
      this.id,
      this.photo,
      this.name,
      this.lastName,
      this.job,
      this.state,
      this.turn,
      this.password});

  factory CareStaff.fromJson(Map<String, dynamic> json) {
    return CareStaff(
        email: json['email'],
        id: json['id'],
        photo: json['photo'],
        name: json['name'],
        lastName: json['lastName'],
        job: json['job'],
        state: json['state'],
        turn: json['turn'],
        password: json['password']);
  }
}
