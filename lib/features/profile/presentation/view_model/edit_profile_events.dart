import 'dart:io';

import 'package:equatable/equatable.dart';
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