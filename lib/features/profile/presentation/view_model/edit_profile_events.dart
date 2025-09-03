import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/profile/api/models/edit_profile/request/edit_profile_request.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class EditProfileEvent extends Equatable{

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class GetUploadProfileEvent extends EditProfileEvent{
  final File photo;
  final String token;
  GetUploadProfileEvent({
    required this.photo, required this.token,
});
  @override
  List<Object?> get props => [photo, token];
}
class GetEditProfileEvent extends EditProfileEvent{
  final EditProfileRequest request;
  final String token;
  GetEditProfileEvent({
    required this.request, required this.token,
  });
  @override
  List<Object?> get props => [request, token];
}