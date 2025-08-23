part of 'login_bloc.dart';

enum RequestState { init, loading, success, error }

@immutable
class LoginState extends Equatable {
  final RequestState loginState;
  final LoginModel? user;
  final String? errorMessage;
  final bool rememberMe;

  LoginState(
      {
        this.loginState = RequestState.loading,
        this.user,
        this.errorMessage = "",
        this.rememberMe = false,
      });

  LoginState copyWith({
    final RequestState? loginState,
    final LoginModel? user,
    final String? errorMessage,
    bool? rememberMe,
  }) {
    return LoginState(
        loginState: loginState ?? this.loginState,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
      rememberMe: rememberMe ?? this.rememberMe,);
  }

  @override
  List<Object?> get props => [loginState, user, errorMessage,rememberMe];
}
