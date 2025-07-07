import 'package:doctor_ease_fe/data/models/user/user_model.dart';

abstract class MeState {}

class MeInitialState extends MeState {}

class MeLoadingState extends MeState {}

//me digunakan untuk menampilkan data user yang sedang login
//state ini akan diisi dengan data user yang didapat dari API
class MeLoadedState extends MeState {
  final User user;

  MeLoadedState({required this.user});
}

class MeErrorState extends MeState {
  final String error;

  MeErrorState({required this.error});
}
