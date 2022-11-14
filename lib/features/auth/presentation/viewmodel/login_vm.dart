import 'package:flutter/material.dart';
import 'package:our_pass/core/services/local_storage.dart';
import 'package:our_pass/di.dart';
import 'package:our_pass/features/auth/datasource/auth_datasource.dart';
import 'package:our_pass/features/auth/presentation/widget/otp_inputfield_widget.dart';
import 'package:our_pass/features/auth/presentation/widget/otp_widget.dart';
import 'package:our_pass/features/dashboard/dashboard.dart';
import 'package:our_pass/utils/notification_util.dart';
import 'package:our_pass/utils/theme.dart';

class AuthProvider extends ChangeNotifier {
  var authHandler = Auth();
  final TextEditingController emailTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();
  final TextEditingController userNameTEC = TextEditingController();

  List? _userData;
  List? get userData => _userData;
  set userData(List? value) {
    _userData = value;
    notifyListeners();
  }

  void init() {
    userData = sl<LocalStorage>().getCachedUserData();
    emailTEC.text = userData?[1] ?? '';
  }

  bool _signIn = true;
  bool get signIn => _signIn;
  set signIn(bool value) {
    disposeTEC();
    _loading = false;
    _signIn = value;
    notifyListeners();
  }

  bool _obscureText = true;
  bool get obscureText => _obscureText;
  set obscureText(bool value) {
    _obscureText = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool _otpValid = false;
  bool get otpValid => _otpValid;
  set otpValid(bool value) {
    _otpValid = value;
    notifyListeners();
  }

  void disposeTEC() {
    emailTEC.clear();
    passwordTEC.clear();
    userNameTEC.clear();
  }

  void showOtpWidget(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: false,
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (context) => BottomSheetWidget(
        sheetBody: Padding(
          padding: const EdgeInsets.symmetric(vertical: 44, horizontal: 24),
          child: Column(
            children: [
              Text(
                'OTP Verification',
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      color: const Color(0xff333D47),
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Enter any random six(6) digit',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      color: const Color(0xff6C7884),
                      fontWeight: FontWeight.w400,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 48,
              ),
              const Padding(
                padding: EdgeInsets.zero,
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Enter OTP',
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: CustomOtpInputField(
                  controller: TextEditingController(),
                  currentCode: '',
                ),
              ),
              const SizedBox(
                height: 48,
              ),
              if (loading)
                const CircularProgressIndicator.adaptive()
              else
                TextButton(
                  onPressed: () async {
                    if (!otpValid) {
                      showInfoNotification('Invalid OTP entered');
                      return;
                    }

                    loading = true;
                    //call firebase login
                    final user = await authHandler.handleSignUp(
                      emailTEC.text.trim(),
                      passwordTEC.text,
                      userNameTEC.text,
                    );

                    if (user != null) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                          (Route<dynamic> route) => false);
                    }
                    loading = false;
                    //if successful, navigate to OTP screen
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
                  child: const Text('Sign Up'),
                ),
              const Spacer(),
              const SizedBox(
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
