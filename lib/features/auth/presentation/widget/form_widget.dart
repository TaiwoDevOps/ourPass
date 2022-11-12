import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:our_pass/features/auth/presentation/viewmodel/login_vm.dart';
import 'package:our_pass/utils/theme.dart';

class BuildForm extends StatelessWidget {
  const BuildForm(this.provider, {Key? key}) : super(key: key);
  final LoginProvider provider;
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: provider.emailTEC,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            decoration: InputDecoration(
              errorMaxLines: 2,
              isCollapsed: true,
              fillColor: appColors.black.withOpacity(.4),
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 16, 15),
              hintText: 'Email address',
              //  counter: ,
              counterStyle: const TextStyle(fontSize: 0),
              errorStyle: TextStyle(
                color: appColors.error,
                fontWeight: FontWeight.w300,
              ),
              hintStyle: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: appColors.black.withOpacity(.4),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: appColors.black.withOpacity(.4),
                  width: 1.12,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: appColors.error,
                  width: 1.12,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: appColors.error,
                  width: 1.12,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: appColors.darkGreen,
                  width: 1.12,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: const Color(0xFF4F4F4F).withOpacity(0.4),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: const Color(0xFF4F4F4F).withOpacity(0.4),
                  width: 1.12,
                ),
              ),
            ),
            validator: (value) {
              if (value!.isNotEmpty) {
                return null;
              } else if (value.isEmpty) {
                return 'Email should not be blank';
              } else {
                return 'Please enter a valid email address';
              }
            },
          ),
          const SizedBox(height: 50),
          // BoatFilledButton(
          //   title: kSignIn,
          //   onPressed: () async {
          //     if (_formKey.currentState!.validate()) {
          //       final successful = await provider.signIn(context);
          //       if (successful) {
          //         // ignore: use_build_context_synchronously
          //         unawaited(
          //           // ignore: use_build_context_synchronously
          //           Provider.of<AuthSessionProvider>(context, listen: false)
          //               .refresh(),
          //         );
          //       }
          //     }
          //   },
          // ),
          const SizedBox(height: 20),

          InkWell(
            onTap: () {},
            child: Align(
              child: RichText(
                text: TextSpan(
                  text: 'text',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: appColors.black.withOpacity(.4),
                  ),
                  children: [
                    TextSpan(
                      text: 'coloredText',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: appColors.green,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
