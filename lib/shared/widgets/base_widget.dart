import 'package:flutter/material.dart';

class BaseWidget extends StatelessWidget {
  const BaseWidget({super.key, required this.child, this.floatingActionButton});
  final Widget child;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: floatingActionButton,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: child,
      ),
    );
  }
}
