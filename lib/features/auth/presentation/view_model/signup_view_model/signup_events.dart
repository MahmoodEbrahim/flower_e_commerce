
import 'package:flower_e_commerce/features/auth/domain/entity/signup_request_model.dart';


abstract class SignUpEvent {}

class CreateUserEvent extends SignUpEvent {
  final SignupRequestModel userModel;
  CreateUserEvent({
    required this.userModel,
  });
  
}
