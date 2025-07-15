import 'package:doctor_ease_fe/data/service/appoinment_service.dart';
import 'package:doctor_ease_fe/presentation/home/appointment/blocs/appointment_event.dart';
import 'package:doctor_ease_fe/presentation/home/appointment/blocs/appointment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentService service;

  AppointmentBloc(this.service) : super(InitialAppointments()) {
    //handle fetch atau get data
    on<LoadAppointments>((event, emit) async {
      emit(LoadingAppointment());
      try {
        final appointment = await service.getAppointment();
        emit(LoadedAppointments(appointment));
      } catch (e) {
        emit(FailureAppointment(e.toString()));
      }
    });

    on<CreateAppoinments>((event, emit) async {
      emit(LoadingAppointment());
      try {
        final response = await service.appointment(event.request);
        emit(SuccesAppointment(response));
      } catch (e) {
        emit(FailureAppointment(e.toString()));
      }
    });

    on<UpdateAppointment>((event, emit) async {
      emit(LoadingAppointment());
      try {
        final response = await service.updateAppointment(
          event.id,
          event.request,
        );
        emit(SuccesAppointment(response));
      } catch (e) {
        emit(FailureAppointment(e.toString()));
      }
    });

    on<DeleteAppointment>((event, emit) async {
      emit(LoadingAppointment());
      try {
        final response = await service.deleteAppointment(event.id);
        emit(SuccesDeleteAppointment(response));
      } catch (e) {
        emit(FailureAppointment(e.toString()));
      }
    });
  }
}
