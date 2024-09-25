import 'package:flutter/material.dart';
import 'package:spotify/core/styles/colors.dart';

class SideBarMenuItem {
  final String title;
  final String asset;
  final Icon? icon;
  final bool active;
  final Color? activeBgColor;
  final Color? activeTextColor;
  final onTap;

  const SideBarMenuItem(
      {required this.title,
      this.asset = '',
      this.onTap,
      this.icon,
      this.active = false,
      this.activeBgColor,
      this.activeTextColor});

  Color bgColor(BuildContext context) => active
      ? activeBgColor ?? Theme.of(context).primaryColor
      : Theme.of(context).primaryColorLight;

  Color? textColor(BuildContext context) => active
      ? activeTextColor ?? Theme.of(context).primaryColorLight
      : dimBlackColor;
}
