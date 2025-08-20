import 'package:doctor_ease_fe/data/repositories/specialization_repository.dart';
import 'package:doctor_ease_fe/presentation/blocs/home/specialization_blocs/specialization_event.dart';
import 'package:doctor_ease_fe/presentation/blocs/home/specialization_blocs/specialization_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecializationBloc
    extends Bloc<SpecializationEvent, SpecializationState> {
  final SpecializationRepository specializationRepository;
  SpecializationBloc({required this.specializationRepository})
    : super(InitialSpecializationState()) {
    on<GetAllSpecializationEvent>((event, emit) async {
      emit(LoadingSpecializationState());
      try {
        final data = await specializationRepository.specializations();
        emit(LoadedGetAllSpecializationState(response: data));
      } catch (e) {
        emit(FailureSpecializationState(error: e.toString()));
      }
    });
  }
}
