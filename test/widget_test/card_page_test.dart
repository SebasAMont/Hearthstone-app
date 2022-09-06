import 'package:first_app/src/core/util/constants_strings.dart';
import 'package:first_app/src/data/model/card.dart';
import 'package:first_app/src/presentation/view/card_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'widget_mocks.dart';

void main() {
  final HearthstoneCard hsCard = HearthstoneCard(
    name: 'Deathwing',
    cardId: '2',
    locale: 'localin',
    cardSet: 'classic',
    dbfId: '312',
    type: 'Dragon',
    text: 'friendly',
    health: 12,
    playerClass: 'np',
    mechanics: [],
  );
  Widget buildWidget() {
    return MaterialApp(
      home: CardPage(
        hearthstoneCard: hsCard,
      ),
    );
  }

  group('cardPage', () {
    testWidgets(
      'checks functionality of like button in CardPage',
      (tester) async {
        await tester.pumpWidget(
          buildWidget(),
        );
        expect(
          find.text('asd'),
          findsNothing,
        );
        expect(
          find.text('$cardPageCounterText $counterCardPage'),
          findsOneWidget,
        );
        expect(
          find.text('Likes 0'),
          findsOneWidget,
        );
        await tester.scrollUntilVisible(
          find.byType(ElevatedButton),
          100.0,
        );
        await tester.tap(
          find.byType(ElevatedButton),
          //  find.byType(ElevatedButton),
        );
        await tester.pump(
          const Duration(seconds: 1),
        );
        expect(
          find.text('$cardPageCounterText 1'),
          findsOneWidget,
        );
        await tester.tap(
          find.byType(ElevatedButton),
          //  find.byType(ElevatedButton),
        );
        await tester.tap(
          find.byType(ElevatedButton),
          //  find.byType(ElevatedButton),
        );
        await tester.pump(
          const Duration(seconds: 1),
        );
        expect(
          find.text('$cardPageCounterText 3'),
          findsOneWidget,
        );
      },
    );
    testWidgets('checks if  default image is shown', (tester) async {
      await tester.pumpWidget(
        buildWidget(),
      );
      expect(
        find.byType(Image),
        findsOneWidget,
      );
    });
    testWidgets('checks if cardName is shown', (tester) async {
      await tester.pumpWidget(
        buildWidget(),
      );

      expect(
        find.text('$cardName  Deathwing'),
        findsOneWidget,
      );
    });
  });
}
