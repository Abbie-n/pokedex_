import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(
            top: 20,
            bottom: 20,
          ),
          child: child,
        ),
      ),
    );
  }
}
