import 'package:doctor_ease_fe/data/service/appoinment_service.dart';
import 'package:doctor_ease_fe/presentation/home/blocs/appointment/appointment_event.dart';
import 'package:doctor_ease_fe/presentation/home/blocs/appointment/appointment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final AppointmentService service;

  AppointmentBloc({required this.service}) : super(InitialAppointments()) {
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

    on<CreateAppointments>((event, emit) async {
      emit(LoadingAppointment());
      try {
        final response = await service.appointment(event.request);
        emit(SuccessAppointment(response));
        add(
          LoadAppointments(),
        ); //memang load juga agar setelah operasi create bisa langsung di refresh
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
        emit(SuccessAppointment(response));
        add(LoadAppointments());
      } catch (e) {
        emit(FailureAppointment(e.toString()));
      }
    });

    on<DeleteAppointment>((event, emit) async {
      emit(LoadingAppointment());
      try {
        final response = await service.deleteAppointment(event.id);
        emit(SuccessDeleteAppointment(response));
        add(LoadAppointments());
      } catch (e) {
        emit(FailureAppointment(e.toString()));
      }
    });
  }
}
