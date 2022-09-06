import 'package:first_app/src/presentation/widget/visibility_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'widget_mocks.dart';

void main() {
  group('visibilitytext', () {
    testWidgets('verify that there visibilitytext works intended',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: VisibilityText(
            cardAttribute: visibilityTextString,
            isVisible: true,
          ),
        ),
      );
      expect(find.text(visibilityTextString), findsOneWidget);
    });
    testWidgets(
        'verify that there visibilitytext works intended by sending false',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: VisibilityText(
            cardAttribute: visibilityTextString,
            isVisible: false,
          ),
        ),
      );
      expect(find.text(visibilityTextString), findsNothing);
    });
    testWidgets(
        'verify that there visibilitytext works intended by sending true but the texts dont match',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: VisibilityText(
            cardAttribute: 'notAnAttribute',
            isVisible: true,
          ),
        ),
      );
      expect(find.text(visibilityTextString), findsNothing);
    });
  });
}
