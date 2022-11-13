import 'package:flutter/material.dart';
import 'package:our_pass/features/auth/presentation/screens/signup_screen.dart';
import 'package:our_pass/features/auth/presentation/viewmodel/login_vm.dart';
import 'package:our_pass/features/dashboard/dashboard.dart';
import 'package:our_pass/utils/theme.dart';
import 'package:our_pass/utils/validator_util.dart';

class BuildForm extends StatelessWidget {
  const BuildForm(this.provider, {Key? key}) : super(key: key);
  final LoginProvider provider;
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!provider.signIn)
            inputField(
              context,
              controller: provider.userNameTEC,
              validator: Validator.nonEmptyField,
              label: 'Username',
              hintText: 'Enter username',
            ),
          const SizedBox(
            height: 10,
          ),
          inputField(
            context,
            controller: provider.emailTEC,
            validator: Validator.emailValidator,
            label: 'Email',
            hintText: 'Enter email address',
          ),
          const SizedBox(
            height: 10,
          ),
          inputField(
            context,
            controller: provider.passwordTEC,
            validator: Validator.password,
            label: 'Password',
            hintText: 'Enter password',
          ),
          const SizedBox(height: 50),
          TextButton(
            onPressed: () {
              provider.showOtpWidget(context: context);

              if (_formKey.currentState!.validate()) {
                if (provider.signIn) {
                  //call firebase login

                  //if success, navigate to dashboard
                } else {
                  //call firebase sign up
                  provider.showOtpWidget(context: context);
                  //if successful, navigate to OTP screen
                }
              }
            },
            style: TextButton.styleFrom(
              backgroundColor: appColors.darkGreen,
              primary: appColors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  10,
                ),
              ),
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              minimumSize: const Size(
                double.infinity,
                50,
              ),
            ),
            child: const Text('Sign In'),
          ),
          const SizedBox(height: 20),
          if (provider.signIn)
            InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => const SignUpScreen()),
                    (Route<dynamic> route) => false);
              },
              child: Align(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account ? ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: appColors.black.withOpacity(.4),
                    ),
                    children: [
                      TextSpan(
                        text: 'Sign Up here',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: appColors.green,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  TextFormField inputField(
    BuildContext context, {
    String? hintText,
    String? label,
    String? Function(String?)? validator,
    TextEditingController? controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        errorMaxLines: 2,
        labelText: label,
        labelStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: appColors.black.withOpacity(0.7),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
        isCollapsed: true,
        fillColor: appColors.black.withOpacity(.4),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 16, 15),
        hintText: hintText,
        errorStyle: TextStyle(
          color: appColors.error,
          fontWeight: FontWeight.w300,
        ),
        hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
              color: appColors.black.withOpacity(.4),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: appColors.black.withOpacity(.4),
            width: 1.12,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: appColors.error,
            width: 1.12,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: appColors.error,
            width: 1.12,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: appColors.darkGreen,
            width: 1.12,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: const Color(0xFF4F4F4F).withOpacity(0.4),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: const Color(0xFF4F4F4F).withOpacity(0.4),
            width: 1.12,
          ),
        ),
      ),
      validator: validator,
    );
  }
}
