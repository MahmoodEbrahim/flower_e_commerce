
import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/user_model.dart';

class SignUpState extends Equatable {
  final bool isLoading;
  final UserModel? userModel;
 final  String? errorMessage;
const  SignUpState({
    this.isLoading=true,
    this.userModel,
    this.errorMessage
});

  

  SignUpState copyWith({
    bool? isLoading,
    UserModel? userModel,
    String? errorMessage,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      userModel: userModel ,
      errorMessage: errorMessage,
    );
  }
  
  @override
  
  List<Object?> get props => [isLoading,userModel,errorMessage];



}
