import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({
    super.key,
    required this.children,
    this.scrollController,
  });

  final List<Widget> children;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: GridView.count(
        controller: scrollController,
        padding: EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        mainAxisSpacing: 12,
        crossAxisSpacing: 10,
        childAspectRatio: 2 / 3.2,
        crossAxisCount: 3,
        children: children,
      ),
    );
  }
}
