import 'package:flower_e_commerce/config/routes_manager/app_routes.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/config/theme/app_theme.dart';
import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/di/di.dart';
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
    return BlocProvider<LoginBloc>(
      create: (context) => getIt<LoginBloc>(),
      child: Scaffold(
        appBar: AppBar(title: const Text("Login")),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state.loginState == RequestState.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Login Success ✅")),
              );
              // TODO: Navigate to Home
              // Navigator.pushReplacementNamed(context, AppRoutes.home);
            }
            if (state.loginState == RequestState.error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text(state.errorMessage ?? "server error , try again")),
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
                        decoration: const InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Email is required";
                          }
                          final emailRegex =
                              RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                          if (!emailRegex.hasMatch(value)) {
                            return "This Email is not valid";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          hintText: "Enter your password",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }
                          if (!RegExp(r'[A-Z]').hasMatch(value)) {
                            return "Add at least 1 uppercase"; //
                          }
                          if (!RegExp(r'\d').hasMatch(value)) {
                            return "Add at least 1 number"; //
                          }
                          return null;
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
                            "Remember me",
                            style: getRegularStyle(
                                color: AppColors.black, fontSize: FontSize.s14),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(context, AppRoutes.forgetpass);
                            },
                            child: Text(
                              "Forget password?",
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
                              Navigator.pushNamed(context, AppRoutes.signup);
                            }
                          },
                          child: Text(
                            "Login",
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
                            onPressed: () {},
                            child: Text(
                              "Continue as guest",
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
                          Navigator.pushNamed(context, AppRoutes.signup);
                        },
                        child: Text.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: "Don't have an account? ",
                              style: getRegularStyle(
                                  color: AppColors.black,
                                  fontSize: FontSize.s16),
                            ),
                            TextSpan(
                              text: "Sign up",
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
