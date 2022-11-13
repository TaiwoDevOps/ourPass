import 'package:flutter/material.dart';
import 'package:our_pass/utils/theme.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CustomOtpInputField extends StatefulWidget {
  const CustomOtpInputField({
    Key? key,
    this.currentCode,
    this.controller,
  }) : super(key: key);

  final String? currentCode;
  final TextEditingController? controller;

  @override
  State<CustomOtpInputField> createState() => _CustomOtpInputFieldState();
}

class _CustomOtpInputFieldState extends State<CustomOtpInputField> {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      pastedTextStyle: TextStyle(
        color: appColors.green,
        fontWeight: FontWeight.bold,
      ),
      length: 6,
      obscureText: true,
      obscuringCharacter: '*',
      blinkWhenObscuring: true,
      animationType: AnimationType.fade,
      validator: (v) {
        if (v!.length < 3) {
          return "I'm from validator";
        } else {
          return null;
        }
      },
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
      ),
      cursorColor: Colors.black,
      animationDuration: const Duration(milliseconds: 300),
      controller: widget.controller,
      keyboardType: TextInputType.number,
      onCompleted: (v) {
        debugPrint("Completed");
        FocusScope.of(context).requestFocus(FocusNode());
      },
      onChanged: (value) {
        debugPrint(value);
      },
    );
  }
}
