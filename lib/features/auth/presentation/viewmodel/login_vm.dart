import 'package:flutter/material.dart';
import 'package:our_pass/features/auth/presentation/widget/otp_inputfield_widget.dart';
import 'package:our_pass/features/auth/presentation/widget/otp_widget.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();
  final TextEditingController userNameTEC = TextEditingController();
  final TextEditingController pinTEC = TextEditingController();

  bool _signIn = true;
  bool get signIn => _signIn;
  set signIn(bool value) {
    _signIn = value;
    notifyListeners();
  }

  bool _loading = false;
  bool get loading => _loading;
  set loading(bool value) {
    disposeTEC();
    _loading = value;
    notifyListeners();
  }

  void disposeTEC() {
    emailTEC.clear();
    passwordTEC.clear();
    userNameTEC.clear();
  }

  void showOtpWidget({
    required BuildContext context,
  }) {
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
                  controller: pinTEC,
                  currentCode: pinTEC.text,
                ),
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
