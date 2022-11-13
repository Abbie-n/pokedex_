import 'package:flutter/material.dart';
import 'package:pokedex/shared/shared.dart';

class VitalsWidget extends StatelessWidget {
  const VitalsWidget({
    super.key,
    required this.value,
    required this.vitalsName,
  });
  final String vitalsName;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            vitalsName,
            textColor: AppColors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          const YMargin(8),
          TextWidget(
            value,
            textColor: AppColors.darkText,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
