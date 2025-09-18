import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';

enum UserSessionStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  authenticatedGuest,
  error,
}

class UserSessionState {
  final UserSessionStatus status;
  final String? token;
  final UserModel? user;
  final String? errorMessage;

  const UserSessionState({
    this.status = UserSessionStatus.initial,
    this.token,
    this.user,
    this.errorMessage,
  });

  UserSessionState copyWith({
    UserSessionStatus? status,
    String? token,
    UserModel? user,
    String? errorMessage,
  }) {
    return UserSessionState(
      status: status ?? this.status,
      token: token ?? this.token,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
