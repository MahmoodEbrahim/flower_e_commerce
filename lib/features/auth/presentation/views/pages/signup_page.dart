import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/signup_request_model.dart';
import 'package:flower_e_commerce/features/auth/domain/usecase/signup_usecase.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final SignupUsecase signupUsecase = getIt.get<SignupUsecase>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: TextButton(
              onPressed: () {
               signupUsecase.signUp(
  SignupRequestModel(
    firstName: "ayayay",
    lastName: "Tech",
    email: "aya222@gmail.com",
    password: "Ahmed@123",
    repassword: "Ahmed@123",
    phone: "+201010700999",
    gender: "male",
  ),
);

              },
              child: Text("click here"))),
    );
  }
}
