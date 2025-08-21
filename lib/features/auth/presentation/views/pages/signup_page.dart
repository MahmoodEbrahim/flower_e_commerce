import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/signup_view_model/signup_state.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/signup_view_model/signup_view_model.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupPage extends StatelessWidget {
  final SignupViewModel _signupViewModel = getIt.get<SignupViewModel>();
  SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return BlocProvider.value(
      
      value: _signupViewModel,
      child: BlocListener<SignupViewModel, SignUpState>(
        listener: (context, state) {
        
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
          if (state.userModel != null) {
            //Navigator to login
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${state.userModel!.firstName}")));
          } 
        },
        child: Scaffold(
          backgroundColor: AppColors.White,
          appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back_ios)),
            backgroundColor: AppColors.White,
            title: Text(t.signUp),
          ),
          body: Column(
            children: [
              SignupForm(
                signupViewModel: _signupViewModel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
