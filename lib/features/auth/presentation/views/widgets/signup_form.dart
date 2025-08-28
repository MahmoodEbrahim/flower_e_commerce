import 'package:flower_e_commerce/config/theme/font_manger.dart';
import 'package:flower_e_commerce/config/theme/font_style_manger.dart';
import 'package:flower_e_commerce/core/l10n/translations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flower_e_commerce/config/theme/app_color.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custum_text.dart';
import 'package:flower_e_commerce/features/auth/presentation/views/widgets/custum_radio_tile.dart';
import 'package:flower_e_commerce/core/validator/signup_validator.dart';
import 'package:flower_e_commerce/features/auth/domain/entity/signup_request_model.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/signup_view_model/signup_events.dart';
import 'package:flower_e_commerce/features/auth/presentation/view_model/signup_view_model/signup_view_model.dart';

class SignupForm extends StatefulWidget {
  final SignupViewModel signupViewModel;
  const SignupForm({super.key, required this.signupViewModel});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {


  
  final GlobalKey<FormState> formKey = GlobalKey();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  ValueNotifier<String?> groupValue = ValueNotifier(null);

  

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: local.firstName,
                      hintText: local.enterFirstName,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      errorMaxLines: 5,
                    ),
                    validator: (value) =>
                        SignupValidators.firstNameValidation(value),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: _lastNameController,
                    decoration: InputDecoration(
                      labelText: local.lastName,
                      hintText: local.enterLastName,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      errorMaxLines: 5,
                    ),
                    validator: (value) =>
                        SignupValidators.lastNameValidation(value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: local.email,
                hintText: local.enterEmail,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                errorMaxLines: 5,
              ),
              validator: (value) => SignupValidators.emailValidation(value),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: local.password,
                      hintText: local.enterPassword,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      errorMaxLines: 5,
                    ),
                    validator: (value) =>
                        SignupValidators.passwordValidation(value),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextFormField(
                    controller: _rePasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: local.confirmPassword,
                      hintText: local.enterConfirmPassword,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      errorMaxLines: 5,
                    ),
                    validator: (value) =>
                        SignupValidators.confirmPasswordValidation(
                            _passwordController.text, _rePasswordController),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: local.phoneNumber,
                hintText: local.enterPhoneNumber,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                errorMaxLines: 5,
              ),
              validator: (value) => SignupValidators.phoneValidation(value),
            ),
            const SizedBox(height: 25),
            ValueListenableBuilder(
              valueListenable: groupValue,
              builder: (context, value, child) {
                return CustumRadioTile(
                  value: value,
                  groupValue: groupValue,
                );
              },
            ),
            CustumText(
              primaryText: local.creatingAccountAgreement,
              secondryText: local.termsAndConditions,
              onTab: () {
                // go to terms page
              },
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: checkValidation,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        local.signUp,
                        style: getRegularStyle(
                            color: Colors.white, fontSize: FontSize.s16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CustumText(
              primaryText: local.alreadyHaveAccount,
              secondryText: local.login,
              color: AppColors.Pink,
              fontSize: FontSize.s18,
              onTab: () {
                // go to login page
              },
            ),
          ],
        ),
      ),
    );
  }

  void checkValidation() {
    if (formKey.currentState!.validate()) {
      final firstName = _firstNameController.text.trim();
      final lastName = _lastNameController.text.trim();
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final rePassword = _rePasswordController.text.trim();
      final phone = _phoneController.text.trim();
      final gender = groupValue.value;
      widget.signupViewModel.add(CreateUserEvent(
        userModel: SignupRequestModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          repassword: rePassword,
          phone: phone,
          gender: gender,
        ),
      ));
    }
  }
}
