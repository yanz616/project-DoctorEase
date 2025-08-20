import 'package:doctor_ease_fe/data/models/specialization/specialization_model.dart';

abstract class SpecializationState {}

class InitialSpecializationState extends SpecializationState {}

class LoadingSpecializationState extends SpecializationState {}

class LoadedGetAllSpecializationState extends SpecializationState {
  final List<Specialization> response;

  LoadedGetAllSpecializationState({required this.response});
}

class FailureSpecializationState extends SpecializationState {
  final String error;
  FailureSpecializationState({required this.error});
}
