import 'package:doctor_ease_fe/data/service/profile_service.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/profile_event.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/profile_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileService service;
  ProfileBloc({required this.service}) : super(InitialProfileState()) {
    on<GetMeEvent>((event, emit) async {
      emit(LoadingProfileState());
      try {
        final user = await service.me();
        emit(GetMeLoaded(user));
      } catch (e) {
        emit(FailureProfileState(e.toString()));
      }
    });

    on<UpdateProfileEvent>((event, emit) async {
      emit(LoadingProfileState());
      try {
        final response = await service.updateProfile(event.request);
        emit(UpdatedProfile(response));
      } catch (e) {
        emit(FailureProfileState(e.toString()));
      }
    });
  }
}
