

import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class SettingState {}

final class SettingInitial extends SettingState {}
final class LanguageChangeState extends SettingState {}
final class SaveLanguageState extends SettingState {}
final class getLanguageState extends SettingState {}
final class GetProfileDataSuccessState extends SettingState {
  UserModel userModel;
  GetProfileDataSuccessState(this.userModel);
}
final class GetProfileDataErrorState extends SettingState {
 final String error;
 GetProfileDataErrorState(this.error);
}
final class GetLogOutSuccessState extends SettingState {

}
final class GetLogOutErrorState extends SettingState {
  final String error;
  GetLogOutErrorState(this.error);
}


