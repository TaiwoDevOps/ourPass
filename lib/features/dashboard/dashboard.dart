import 'package:flutter/material.dart';
import 'package:our_pass/features/auth/presentation/screens/login_screen.dart';
import 'package:our_pass/features/auth/presentation/viewmodel/login_vm.dart';
import 'package:our_pass/utils/theme.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AuthProvider loginProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      loginProvider.init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loginProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              loginProvider.authHandler.handleSignOut().then((value) => {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const LoginScreen()),
                        (Route<dynamic> route) => false),
                  });
            },
            child: Align(
                child: Text(
              'Log Out',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: appColors.error,
              ),
            )),
          ),
          const SizedBox(
            width: 30,
          ),
        ],
      ),
      body: Center(
        child: Text('You are home ---${loginProvider.userData?[0] ?? ''}'),
      ),
    );
  }
}
