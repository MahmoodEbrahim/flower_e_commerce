part of 'login_bloc.dart';

enum RequestState { init, loading, success, error }

@immutable
class LoginState extends Equatable {
  final RequestState loginState;
  final LoginEntity? user;
  final String? errorMessage;

  LoginState(
      {this.loginState = RequestState.loading, this.user, this.errorMessage = ""});

  LoginState copyWith({
    final RequestState? loginState,
    final LoginEntity? user,
    final String? errorMessage,
  }) {
    return LoginState(
        loginState: loginState ?? this.loginState,
        user: user, // هنا بنسيبها زي ما هي، مش بنعمل ?? this.user
        // user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  List<Object?> get props => [loginState, user, errorMessage];
}
