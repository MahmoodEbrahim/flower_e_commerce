import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/profile/api/models/change_password/request/change_password_request.dart';

abstract class ChangePasswordEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class GetChangePasswordEvent extends ChangePasswordEvent{
 final  ChangePasswordRequest changePasswordRequest;
 final String token;
  GetChangePasswordEvent({required this.changePasswordRequest,required this.token});
  @override
  // TODO: implement props
  List<Object?> get props => [changePasswordRequest];
}