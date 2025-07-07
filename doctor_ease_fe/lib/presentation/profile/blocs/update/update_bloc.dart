import 'package:doctor_ease_fe/data/service/profile_service.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/update/update_event.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/update/update_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  final ProfileService profileService;

  UpdateBloc({required this.profileService}) : super(UpdateInitialState()) {
    on<UpdateLoadEvent>((event, emit) async {
      emit(UpdateLoadingState());
      try {
        final response = await profileService.updateProfile(event.request);
        emit(UpdateLoadedState(response: response));
      } catch (e) {
        emit(UpdateErrorState(error: e.toString()));
      }
    });
  }
}
