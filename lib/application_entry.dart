import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@injectable
class ApplicationEntry extends StatefulWidget {
  @override
  State<ApplicationEntry> createState() => _ApplicationEntryState();
}

class _ApplicationEntryState extends State<ApplicationEntry> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return const Placeholder();
  }
}