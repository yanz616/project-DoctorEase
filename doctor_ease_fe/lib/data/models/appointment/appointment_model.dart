class AppointmentModel {
  final int id;
  final int userId;
  final int doctorId;
  final String scheduledAt;
  final String purpose;
  final String status; // default: "pending"

  AppointmentModel({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.scheduledAt,
    required this.purpose,
    required this.status,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      userId: json['user_id'],
      doctorId: json['doctor_id'],
      scheduledAt: json['scheduled_at'],
      purpose: json['purpose'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'doctor_id': doctorId,
      'scheduled_at': scheduledAt,
      'purpose': purpose,
      'status': status,
    };
  }
}
