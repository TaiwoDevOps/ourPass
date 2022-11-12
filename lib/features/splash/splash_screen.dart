import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:our_pass/features/auth/presentation/screens/login_screen.dart';
import 'package:our_pass/utils/log_util.dart';
import 'package:our_pass/utils/theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).whenComplete(() => {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false),
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 2),
        color: appColors.white,
        width: double.infinity,
        onEnd: () {
          Log().debug('did timer end');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (Route<dynamic> route) => false);
        },
        child: Center(
          child: SvgPicture.asset('assets/svg/our_pass.svg'),
        ),
      ),
    );
  }
}
