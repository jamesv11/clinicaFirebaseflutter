class Appointment {
  final String id;
  final bool appointmentState;
  final DateTime dateService;
  final String description;
  final String careStaffId;
  final String patientId;

  Appointment(
      {this.id,
      this.appointmentState,
      this.dateService,
      this.description,
      this.careStaffId,
      this.patientId});

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
        id: json['id'],
        appointmentState: json['appointmentState'],
        dateService: json['dateService'],
        description: json['description'],
        careStaffId: json['careStaffId'],
        patientId: json['patientId']);
  }
}
