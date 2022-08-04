import 'package:flutter/material.dart';
import '../../core/util/card_constants.dart';

class VisibilityText extends StatelessWidget {
  const VisibilityText({
    required this.cardAttribute,
    required this.isVisible,
    super.key,
  });
  final String cardAttribute;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Text(
        cardAttribute,
        style: const TextStyle(
          fontSize: cardTextInfoFontSize,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
