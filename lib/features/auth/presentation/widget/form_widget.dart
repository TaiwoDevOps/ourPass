import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:our_pass/features/auth/presentation/screens/signup_screen.dart';
import 'package:our_pass/features/auth/presentation/viewmodel/login_vm.dart';
import 'package:our_pass/features/dashboard/dashboard.dart';
import 'package:our_pass/utils/theme.dart';
import 'package:our_pass/utils/validator_util.dart';

class BuildForm extends StatelessWidget {
  BuildForm(this.provider, {Key? key}) : super(key: key);
  final AuthProvider provider;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
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
            obscureText: true,
          ),
          const SizedBox(height: 50),
          if (provider.loading)
            const CircularProgressIndicator.adaptive()
          else
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (provider.signIn) {
                    provider.loading = true;
                    //call firebase login
                    provider.authHandler
                        .handleSignInEmail(
                          provider.emailTEC.text.trim(),
                          provider.passwordTEC.text,
                        )
                        .then(
                          (user) => {
                            provider.loading = false,
                            if (user != null)
                              {
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeScreen()),
                                    (Route<dynamic> route) => false),
                              }
                          },
                        );
                  } else {
                    provider.loading = true;

                    //call firebase sign up
                    Future.delayed(const Duration(milliseconds: 500)).then(
                      (value) => {
                        provider.loading = false,
                        provider.showOtpWidget(context),
                      },
                    );
                    //if successful, navigate to OTP screen
                  }
                }
              },
              style: TextButton.styleFrom(
                foregroundColor: appColors.white,
                backgroundColor: appColors.darkGreen,
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
              child: Text('Sign ${provider.signIn ? 'In' : 'Up'}'),
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
          const SizedBox(
            height: 50,
          ),
          if (provider.signIn && provider.canAuthLocally)
            Center(
              child: CircleAvatar(
                radius: 35,
                backgroundColor: appColors.green,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    iconSize: 64,
                    icon: Icon(
                      Icons.fingerprint,
                      size: 40,
                      color: appColors.white,
                    ),
                    onPressed: () async {
                      final res = await provider.localAuthHandler
                          .handleLocalAuthSignIn();
                      if (res) {
                        provider.loading = true;
                        //call firebase login
                        provider.authHandler
                            .handleSignInEmail(
                              provider.emailTEC.text.trim(),
                              provider.tempPassword,
                            )
                            .then(
                              (user) => {
                                provider.loading = false,
                                if (user != null)
                                  {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomeScreen()),
                                        (Route<dynamic> route) => false),
                                  }
                              },
                            );
                      }
                    },
                  ),
                ),
              ),
            )
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
    bool obscureText = false,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
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
