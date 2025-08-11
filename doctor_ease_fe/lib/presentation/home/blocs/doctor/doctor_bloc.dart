import 'package:doctor_ease_fe/data/service/doctor_service.dart';
import 'package:doctor_ease_fe/presentation/home/blocs/doctor/doctor_event.dart';
import 'package:doctor_ease_fe/presentation/home/blocs/doctor/doctor_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorService doctorService;

  DoctorBloc({required this.doctorService}) : super(DoctorInitialState()) {
    on<LoadDoctorsEvent>((event, emit) async {
      emit(DoctorLoadingState());
      try {
        final doctors = await doctorService.getDoctors();
        emit(DoctorLoadedState(doctors: doctors));
      } catch (e) {
        emit(DoctorErrorState(error: e.toString()));
      }
    });
    on<LoadDoctorSpecial>((event, emit) async {
      emit(DoctorLoadingState());
      try {
        final response = await doctorService.getDoctorBySpecialization(
          event.id,
        );
        emit(DoctorSpecialLoadedState(response));
      } catch (e) {
        emit(DoctorErrorState(error: e.toString()));
      }
    });
  }
}
