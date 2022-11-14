import 'package:flutter/material.dart';
import 'package:pokedex/shared/colors.dart';

class CustomProgressIndicator extends StatelessWidget {
  final Color? backgroundColor;
  final Color? progressColor;
  final double? progress;

  const CustomProgressIndicator({
    Key? key,
    this.backgroundColor,
    this.progressColor,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: SizedBox(
        height: 4,
        width: width,
        child: Stack(
          children: [
            Container(
              color: AppColors.scaffoldBg,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: width * progress!,
                decoration: BoxDecoration(
                  color: progressColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
