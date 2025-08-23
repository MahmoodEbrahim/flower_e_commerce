import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/app_theme.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flower_e_commerce/core/utils/validator.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/login_view_model/login_bloc.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/login_view_model/login_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return BlocProvider<LoginBloc>(
      create: (context) => getIt<LoginBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text(locale.login)),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.loginState == RequestState.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(locale.loginSuccess)),
              );
              Navigator.pushReplacementNamed(context, AppRoutes.home);
            }
            if (state.loginState == RequestState.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(
                        state.errorMessage ?? locale.serverError)),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: locale.email,
                          hintText: locale.enterYourEmail,
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                         return Validator.validateEmail(value);
                      }),
                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          labelText: locale.password,
                          hintText: locale.enterYourPassword,
                          border: const OutlineInputBorder(),
                        ),
                        validator: (value) {
                          return Validator.validatePassword(value);
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Checkbox(
                            value: state.rememberMe,
                            onChanged: (value) {
                              context
                                  .read<LoginBloc>()
                                  .add(ToggleRememberMe(value ?? false));
                            },
                          ),
                          Text(
                            locale.rememberMe,
                            style: getRegularStyle(
                                color: AppColors.black, fontSize: FontSize.s14),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.forgetPass);
                            },
                            child: Text(
                              locale.forgetPassword,
                              style: getRegularStyle(
                                color: AppColors.black,
                                fontSize: FontSize.s14,
                              ).copyWith(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              final email = emailController.text.trim();
                              final pass = passwordController.text.trim();

                              context.read<LoginBloc>().add(
                                LoginButtonPressed(
                                  email: email,
                                  password: pass,
                                ),
                              );
                            }
                          },
                          child: Text(
                            locale.login,
                            style: getMediumStyle(
                                color: AppColors.White, fontSize: FontSize.s20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false,);
                            },
                            child: Text(
                              locale.continueAsGuest,
                              style: getMediumStyle(
                                  color: AppColors.gray,
                                  fontSize: FontSize.s20),
                            ),
                            style: AppTheme.lightTheme.elevatedButtonTheme.style
                                ?.copyWith(
                                backgroundColor:
                                WidgetStatePropertyAll(AppColors.White),
                                side: WidgetStateProperty.all(
                                    BorderSide(color: AppColors.gray)))),
                      ),
                      const SizedBox(height: 16),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.signup  );
                        },
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: locale.donotHaveAccount,
                              style: getRegularStyle(
                                  color: AppColors.black,
                                  fontSize: FontSize.s16),
                            ),
                            TextSpan(
                              text: locale.signUp,
                              style: getRegularStyle(
                                color: AppColors.Pink,
                                fontSize: FontSize.s16,
                              ).copyWith(
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.Pink,
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
