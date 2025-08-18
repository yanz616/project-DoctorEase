class AppointmentRequest {
  final int doctorId;
  final String scheduledAt;
  final String purpose;

  AppointmentRequest({
    required this.doctorId,
    required this.scheduledAt,
    required this.purpose,
  });

  Map<String, dynamic> toJson() => {
    'doctor_id': doctorId,
    'scheduled_at': scheduledAt,
    'purpose': purpose,
  };
}
