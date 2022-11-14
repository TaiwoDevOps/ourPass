import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:our_pass/utils/notification_util.dart';

class LocalAuth {
  final auth = LocalAuthentication();

  Future<bool> checkLocalAuthSignIn() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;

    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    return canAuthenticate;
  }

  Future<bool> handleLocalAuthSignIn() async {
    var authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to login',
      );
    } on PlatformException catch (e) {
      var message = '';
      switch (e.code) {
        case auth_error.notAvailable:
          message = 'This device does not have a Touch ID/fingerprint scanner.';
          break;
        case auth_error.passcodeNotSet:
          message = 'You are yet configured a password on the device.';
          break;
        case auth_error.notEnrolled:
          message = 'You have not enrolled any fingerprints on the device.';
          break;
        case auth_error.otherOperatingSystem:
          message = 'The device operating system is not iOS or Android';
          break;
        case auth_error.lockedOut:
          message = 'You have been locked out due to too many attempts';
          break;
        case auth_error.permanentlyLockedOut:
          message =
              'Your biometrics has been disabled due to too many lock outs, authentication like PIN/Pattern/Password is required to unlock.';
          break;
        default:
          message = e.toString();
          break;
      }
      showErrorNotification(message);
    }
    return authenticated;
  }
}
