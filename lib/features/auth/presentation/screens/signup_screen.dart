import 'package:flutter/material.dart';
import 'package:our_pass/features/auth/presentation/viewmodel/login_vm.dart';
import 'package:our_pass/features/auth/presentation/widget/form_widget.dart';
import 'package:our_pass/utils/theme.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late AuthProvider loginProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loginProvider.signIn = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loginProvider = context.watch<AuthProvider>();

    return Consumer<AuthProvider>(
      builder: (_, provider, __) {
        return Scaffold(
          backgroundColor: appColors.white,
          body: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              children: [
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Sign Up',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: appColors.black,
                        fontWeight: FontWeight.w600,
                        height: 2,
                        fontSize: 32,
                      ),
                ),
                const SizedBox(
                  height: 30,
                ),
                BuildForm(provider),
              ],
            ),
          ),
        );
      },
    );
  }
}
