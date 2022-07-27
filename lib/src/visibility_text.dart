import "package:flutter/material.dart";
import 'card_constants.dart';

class VisibilityText extends StatelessWidget {
  const VisibilityText({
    required this.cardAttribute,
    required this.visibleCondition,
    Key? key,
  }) : super(
          key: key,
        );
  final String cardAttribute;
  final bool visibleCondition;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibleCondition,
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
