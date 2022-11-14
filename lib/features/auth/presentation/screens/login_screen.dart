import 'package:flutter/material.dart';
import 'package:our_pass/features/auth/presentation/viewmodel/login_vm.dart';
import 'package:our_pass/features/auth/presentation/widget/form_widget.dart';
import 'package:our_pass/utils/theme.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthProvider loginProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loginProvider
        ..signIn = true
        ..init();
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
                  'Sign In',
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
