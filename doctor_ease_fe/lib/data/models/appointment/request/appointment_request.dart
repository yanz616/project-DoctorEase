class AppointmentRequest {
  final int doctorId;
  final String scheduledAt;
  final String description;

  AppointmentRequest({
    required this.doctorId,
    required this.scheduledAt,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
    'doctor_id': doctorId,
    'scheduled_at': scheduledAt,
    'description': description,
  };
}
