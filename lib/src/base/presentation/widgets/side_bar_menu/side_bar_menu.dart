import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/core/constants/numbers/font_size.dart';
import 'package:spotify/core/constants/numbers/spacings.dart';
import 'package:spotify/core/styles/colors.dart';
import 'package:spotify/src/base/presentation/widgets/side_bar_menu/side_bar_menu_item.dart';

class SideBarMenu extends StatefulWidget {
  final List<SideBarMenuItem> items;
  final bool showDivider;

  const SideBarMenu({Key? key, required this.items, this.showDivider = false})
      : super(key: key);

  @override
  _SideBarMenuState createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: widget.items.asMap().entries.map((entry) {
          final idx = entry.key;
          final item = entry.value;

          return _menuItem(item, idx);
        }).toList(),
      ),
    );
  }

  Widget _menuItem(SideBarMenuItem item, int index) {
    final itemBorderRadius = BorderRadius.only(
      topLeft: Radius.circular(index == 0 ? Spacings.radiusLg : 0),
      topRight: Radius.circular(index == 0 ? Spacings.radiusLg : 0),
      bottomRight: Radius.circular(
          index == widget.items.length - 1 ? Spacings.radiusLg : 0),
      bottomLeft: Radius.circular(
          index == widget.items.length - 1 ? Spacings.radiusLg : 0),
    );
    return Column(
      children: [
        widget.showDivider && index != 0
            ? const Divider(
                height: 1,
                thickness: 1,
                color: greyColor,
              )
            : Container(),
        Container(
          decoration: BoxDecoration(
              borderRadius: itemBorderRadius,
              color: item.bgColor(context),
              boxShadow: [
                BoxShadow(
                  color: item.bgColor(context).withOpacity(.7),
                  spreadRadius: 0,
                  blurRadius: 15,
                  offset: Offset(0, 5), // changes position of shadow
                ),
              ]),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: itemBorderRadius,
              onTap: item.onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: Spacings.paddingMd,
                    horizontal: Spacings.paddingLg),
                child: Row(
                  children: [
                    item.icon ??
                        SvgPicture.asset(
                          item.asset,
                          width: Spacings.size3Xs,
                          color: item.textColor(context),
                        ),
                    const SizedBox(
                      width: Spacings.marginSm,
                    ),
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: kBodyTextColor,
                        fontWeight: FontWeight.normal,
                        fontSize: k14TextFontSize,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
