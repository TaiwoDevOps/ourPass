import 'package:flutter/material.dart';
import 'package:our_pass/core/services/local_storage.dart';
import 'package:our_pass/di.dart';
import 'package:our_pass/features/auth/datasource/auth_datasource.dart';
import 'package:our_pass/features/auth/datasource/local_auth.dart';
import 'package:our_pass/features/auth/presentation/widget/otp_widget.dart';

class AuthProvider extends ChangeNotifier {
  var authHandler = Auth();
  var localAuthHandler = LocalAuth();
  final TextEditingController emailTEC = TextEditingController();
  final TextEditingController passwordTEC = TextEditingController();
  final TextEditingController userNameTEC = TextEditingController();

  String tempPassword = '';
  List? _userData;
  List? get userData => _userData; //NOTE: username => 0, email => 1
  set userData(List? value) {
    _userData = value;
    notifyListeners();
  }

  bool _canAuthLocally = false;
  bool get canAuthLocally => _canAuthLocally;
  set canAuthLocally(bool value) {
    _canAuthLocally = value;
    notifyListeners();
  }

  void init() async {
    userData = sl<LocalStorage>().getCachedUserData();
    tempPassword = sl<LocalStorage>().getPassword();
    emailTEC.text = userData?[1] ?? '';
    _canAuthLocally = userData![1].toString().isNotEmpty &&
        tempPassword.isNotEmpty &&
        await localAuthHandler.checkLocalAuthSignIn();
  }

  bool _signIn = true;
  bool get signIn => _signIn;
  set signIn(bool value) {
    disposeTEC();
    _loading = false;
    _signIn = value;
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
    tempPassword = '';
  }

  void showOtpWidget(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      useRootNavigator: false,
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (context) => BottomSheetWidget(),
    );
  }
}
