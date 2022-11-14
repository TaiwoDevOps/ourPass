import 'package:flutter/material.dart';
import 'package:our_pass/utils/theme.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({
    super.key,
    required this.sheetBody,
    this.onDismissed,
    this.showCloseButton = true,
  });

  final Widget sheetBody;
  final void Function()? onDismissed;
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
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
                  if (showCloseButton)
                    Padding(
                      padding: const EdgeInsets.only(right: 19),
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          onDismissed?.call();
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
                    )
                  else
                    const SizedBox(),
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
                    child: sheetBody,
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
