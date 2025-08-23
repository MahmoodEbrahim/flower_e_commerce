import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
// part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}

class ToggleRememberMe extends LoginEvent {
  final bool value;

  ToggleRememberMe(this.value);
}