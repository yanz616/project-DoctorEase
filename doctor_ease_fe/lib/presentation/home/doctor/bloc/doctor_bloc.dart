import 'package:doctor_ease_fe/data/service/doctor_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'doctor_event.dart';
import 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final DoctorService doctorService;

  DoctorBloc(this.doctorService) : super(DoctorInitialState()) {
    on<LoadDoctorsEvent>(_onLoadDoctors);
  }

  Future<void> _onLoadDoctors(
    LoadDoctorsEvent event,
    Emitter<DoctorState> emit,
  ) async {
    emit(DoctorLoadingState());
    try {
      final doctors = await doctorService.getDoctors();
      emit(DoctorLoadedState(doctors));
    } catch (e) {
      emit(DoctorErrorState('Failed to load doctors: $e'));
    }
  }
}
