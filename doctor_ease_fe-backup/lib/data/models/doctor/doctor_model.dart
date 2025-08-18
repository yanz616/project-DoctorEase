import 'package:doctor_ease_fe/data/models/specialization/specialization_model.dart';

class Doctor {
  final int id;
  final String name;
  final Specialization specialization;
  final String? photo;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    this.photo,
    this.createdAt,
    this.updatedAt,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'] as int,
      name: json['name'] as String,
      specialization: Specialization.fromJson(
        json['specialization'] as Map<String, dynamic>,
      ),
      photo: json['photo'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization.toJson(),
      'photo': photo,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class DoctorSpecial {
  final Specialization specialization;
  final Doctor doctor;

  DoctorSpecial({required this.doctor, required this.specialization});

  factory DoctorSpecial.fromJson(Map<String, dynamic> json) {
    return DoctorSpecial(
      specialization: json['specialization'],
      doctor: Doctor.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'specialization': specialization, 'data': doctor.toJson()};
  }
}
