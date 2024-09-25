import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  return _routes(settings.arguments)[settings.name]!;
}

Map<String, MaterialPageRoute<dynamic>> _routes(args) => {};
