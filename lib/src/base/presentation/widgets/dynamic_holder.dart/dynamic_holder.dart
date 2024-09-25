import 'package:flutter/cupertino.dart';

class DynamicHolder extends StatefulWidget {
  final Widget child;
  final double maxWidth;
  final double? parentWidth;
  final Alignment alignment;
  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;

  const DynamicHolder(
      {Key? key,
      required this.maxWidth,
      this.parentWidth,
      this.alignment = Alignment.center,
      required this.child, this.padding, this.decoration})
      : super(key: key);

  @override
  _DynamicHolderState createState() => _DynamicHolderState();
}

class _DynamicHolderState extends State<DynamicHolder> {
  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints(
            minWidth: widget.parentWidth ?? MediaQuery.of(context).size.width),
        alignment: widget.alignment,
        decoration: widget.decoration,
        padding: widget.padding,
        child: Container(
            constraints: BoxConstraints(maxWidth: widget.maxWidth),
            child: widget.child));
  }
}
