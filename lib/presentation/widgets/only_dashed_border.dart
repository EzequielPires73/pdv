import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class OnlyDashedBorder extends StatelessWidget {
  const OnlyDashedBorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DottedBorder(
        dashPattern: [6, 3],
        color: Colors.grey.shade300,
        strokeWidth: 1,
        padding: EdgeInsets.zero,
        customPath: (size) {
          return Path()
            ..moveTo(0, 0)
            ..lineTo(size.width, 0);
        },
        child: SizedBox(width: double.infinity, height: 1),
      ),
    );
  }
}
