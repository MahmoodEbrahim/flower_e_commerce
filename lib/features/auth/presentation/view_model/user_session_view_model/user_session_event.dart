// user_session_event.dart
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';

abstract class UserSessionEvent {}

class UserLoggedIn extends UserSessionEvent {
  final String token;
  final UserModel user;

  UserLoggedIn(this.token, this.user);
}

class UserLoggedOut extends UserSessionEvent {}

class LoadUserFromCache extends UserSessionEvent {} // لو فيه remember me
class GuestLogin extends UserSessionEvent {}
