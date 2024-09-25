import 'package:flutter/material.dart';
import 'package:spotify/core/constants/numbers/font_size.dart';
import 'package:spotify/core/constants/numbers/spacings.dart';
import 'package:spotify/core/styles/colors.dart';

class Toast extends StatelessWidget {
  final String message;
  final Color bgColor;
  final Color textColor;
  final IconData icon;
  final List<BoxShadow>? shadow;

  const Toast(
      {Key? key,
      required this.message,
      required this.bgColor,
      required this.textColor,
      required this.icon,
      this.shadow})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: Spacings.sizeMaxPageWidth),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: Spacings.marginXl),
        padding: const EdgeInsets.symmetric(
            vertical: Spacings.paddingSm, horizontal: Spacings.paddingLg),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Spacings.radiusLg),
            color: bgColor,
            boxShadow: shadow ??
                [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    spreadRadius: 1,
                    blurRadius: 1.5,
                    offset: const Offset(0, 3),
                  ),
                ]),
        child: Row(
          children: [
            Icon(
              icon,
              color: textColor,
            ),
            const SizedBox(
              width: 12.0,
            ),
            Flexible(
              child: Text(
                message,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: textColor,
                  fontSize: k14TextFontSize,
                ),
                maxLines: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorToast extends StatelessWidget {
  final String message;

  const ErrorToast({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Toast(
        message: message,
        bgColor: dimBlackColor,
        textColor: dangerTextColor,
        shadow: [],
        icon: Icons.warning_rounded);
  }
}

class SuccessToast extends StatelessWidget {
  final String message;

  const SuccessToast({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Toast(
        message: message,
        bgColor: scaffoldBackgroundColor,
        textColor: primaryColor,
        shadow: [],
        icon: Icons.check_box_rounded);
  }
}
