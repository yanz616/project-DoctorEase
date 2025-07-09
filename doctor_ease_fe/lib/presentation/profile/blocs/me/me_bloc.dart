import 'package:doctor_ease_fe/data/service/profile_service.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/me/me_event.dart';
import 'package:doctor_ease_fe/presentation/profile/blocs/me/me_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MeBloc extends Bloc<MeEvent, MeState> {
  final ProfileService profileService;

  MeBloc({required this.profileService}) : super(MeInitialState()) {
    on<MeLoadEvent>((event, emit) async {
      emit(MeLoadingState());
      try {
        final user = await profileService.me();
        print('me bloc');
        print(user);
        emit(MeLoadedState(user: user));
      } catch (e) {
        emit(MeErrorState(error: e.toString()));
      }
    });
  }
}
