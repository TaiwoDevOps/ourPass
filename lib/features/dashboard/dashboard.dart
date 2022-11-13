import 'package:flutter/material.dart';
import 'package:our_pass/features/auth/presentation/screens/login_screen.dart';
import 'package:our_pass/utils/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false);
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
      body: const Center(
        child: Text('You are home ---User Name'),
      ),
    );
  }
}
