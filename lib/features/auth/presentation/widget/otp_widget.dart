import 'package:flutter/material.dart';
import 'package:our_pass/features/auth/presentation/viewmodel/login_vm.dart';
import 'package:our_pass/features/auth/presentation/widget/otp_inputfield_widget.dart';
import 'package:our_pass/features/dashboard/dashboard.dart';
import 'package:our_pass/utils/notification_util.dart';
import 'package:our_pass/utils/theme.dart';
import 'package:provider/provider.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();

    final mediaQuery = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: appColors.darkGreen,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(24),
          topLeft: Radius.circular(24),
        ),
      ),
      height: mediaQuery.height / 1.2,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: mediaQuery.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 19),
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: appColors.white,
                      ),
                      label: Text(
                        'Close',
                        style: Theme.of(context).textTheme.bodyText1!.apply(
                              color: appColors.white,
                            ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Color(0xffFBFBFE),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 44, horizontal: 24),
                      child: Column(
                        children: [
                          Text(
                            'OTP Verification',
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
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
                            style:
                                Theme.of(context).textTheme.bodyText2!.copyWith(
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
                          if (provider.loading)
                            const CircularProgressIndicator.adaptive()
                          else
                            TextButton(
                              onPressed: () async {
                                if (!provider.otpValid) {
                                  showInfoNotification('Invalid OTP entered');
                                  return;
                                }
                                provider.loading = true;

                                //call firebase sign up
                                final user =
                                    await provider.authHandler.handleSignUp(
                                  provider.emailTEC.text.trim(),
                                  provider.passwordTEC.text,
                                  provider.userNameTEC.text,
                                );

                                if (user != null) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen()),
                                      (Route<dynamic> route) => false);
                                }
                                provider.loading = false;
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
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
