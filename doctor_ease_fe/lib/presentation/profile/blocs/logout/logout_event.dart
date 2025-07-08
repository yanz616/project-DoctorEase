abstract class LogoutEvent {}

class LogoutButtonPressed extends LogoutEvent {
  final String token;

  LogoutButtonPressed({required this.token});
}
