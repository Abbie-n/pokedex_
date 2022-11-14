import 'package:flutter/material.dart';
import 'package:pokedex/shared/shared.dart';

class BaseStats extends StatelessWidget {
  const BaseStats({
    super.key,
    required this.stat,
    required this.value,
    required this.progress,
    required this.progressColor,
  });

  final String stat;
  final String value;
  final double progress;
  final Color progressColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        children: [
          Row(
            children: [
              TextWidget(
                stat,
                textColor: AppColors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              const XMargin(8),
              TextWidget(
                value,
                textColor: AppColors.darkText,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ],
          ),
          const YMargin(8),
          CustomProgressIndicator(
            progressColor: progressColor,
            progress: progress,
          ),
        ],
      ),
    );
  }
}
