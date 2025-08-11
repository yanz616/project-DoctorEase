abstract class DoctorEvent {}

class LoadDoctorsEvent extends DoctorEvent {}

class LoadDoctorSpecial extends DoctorEvent {
  final int id;

  LoadDoctorSpecial({required this.id});
}
