import 'dart:async';
import 'package:first_app/src/core/util/card_state.dart';
import 'package:first_app/src/core/util/constants_api_calls.dart';
import 'package:first_app/src/core/util/constants_strings.dart';
import 'package:first_app/src/data/model/card_event.dart';
import 'package:first_app/src/presentation/bloc/card_bloc.dart';
import 'package:first_app/src/presentation/view/card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../mocks.dart';
import 'card_list_widget_test.mocks.dart';

@GenerateMocks([
  http.Client,
  CardBloc,
])
void main() {
  final MockCardBloc mockCardBloc = MockCardBloc();
  final StreamController<CardEvent> streamController =
      StreamController<CardEvent>.broadcast();

  setUp(() {
    when(
      mockCardBloc.cardListStream,
    ).thenAnswer((_) {
      return streamController.stream;
    });
    when(
      mockCardBloc.cardListSink,
    ).thenAnswer((_) {
      return streamController.sink;
    });
    when(
      mockCardBloc.currentPage,
    ).thenAnswer(
      (_) => 0,
    );
    when(
      mockCardBloc.page,
    ).thenAnswer(
      (_) => {0: tenCardsMock},
    );
    when(
      mockCardBloc.numberOfPagesCardList,
    ).thenAnswer(
      (_) => 0,
    );
    when(mockCardBloc.getCardListFromEndpoint(defaultEndpoint))
        .thenAnswer((_) async {
      streamController.sink.add(
        CardEvent(cardState: CardState.success, cards: cardListApiFull),
      );
    });
    when(
      mockCardBloc.sinkPreviousCardList(),
    ).thenAnswer((
      _,
    ) async {
      streamController.sink.add(
        CardEvent(cardState: CardState.success, cards: cardListApiFull),
      );
    });
    when(
      mockCardBloc.sinkNextCardList(),
    ).thenAnswer((_) async {
      streamController.sink.add(
        CardEvent(cardState: CardState.success, cards: cardListApiFull),
      );
    });

    when(
      mockCardBloc.getCardListFromEndpoint(
        kRacesTotemEndpointApi,
      ),
    ).thenAnswer((_) async {
      streamController.sink.add(
        CardEvent(cardState: CardState.success, cards: cardListApiFull),
      );
    });
  });
  group('cardPage', () {
    testWidgets(
      'verify that the appbar text widget displays a correct string',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: CardList(
              cardBloc: mockCardBloc,
            ),
          ),
        );

        expect(
          find.text(
            appBarCardListTitle,
          ),
          findsOneWidget,
        );
        expect(
          find.text(
            "there shouldn't be any",
          ),
          findsNothing,
        );
      },
    );
    testWidgets(
      'verify that the drawer shows the 3 endpoints',
      (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: CardList(
              cardBloc: mockCardBloc,
            ),
          ),
        );
        streamController.sink.add(
          CardEvent(cardState: CardState.success, cards: cardListApiFull),
        );

        await tester.pumpAndSettle();
        final ScaffoldState state = tester.state(
          find.byType(
            Scaffold,
          ),
        );
        state.openEndDrawer();

        await tester.pumpAndSettle();
        expect(state.isEndDrawerOpen, true);
        expect(find.text(kCardListDemons), findsOneWidget);
        expect(find.text(kCardListTotems), findsOneWidget);
        expect(find.text(kCardListMurlocs), findsOneWidget);
      },
    );
  });
  testWidgets(
    'verify that clicking a ListTile changes the current url and the grid is built by streamBuilder showing the cards of the endpoint clicked',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CardList(
            cardBloc: mockCardBloc,
          ),
        ),
      );
      streamController.sink.add(
        cardEventEmpty,
      );
      expect(
        find.text('Animated'),
        findsNothing,
      );
      await tester.pumpAndSettle();

      final ScaffoldState state = tester.state(
        find.byType(Scaffold),
      );
      state.openEndDrawer();

      await tester.pumpAndSettle();
      await tester.tap(
        find.text(kCardListTotems),
      );

      await tester.pumpAndSettle();
      expect(
        find.byType(GridView, skipOffstage: false),
        findsOneWidget,
      );
      expect(find.text('Animated'), findsOneWidget);
    },
  );
  testWidgets(
      'verify that clicking NextPage button changes CurrentPage and updates the cardList',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CardList(
          cardBloc: mockCardBloc,
        ),
      ),
    );
    streamController.sink.add(
      CardEvent(cardState: CardState.success, cards: []),
    );
    await tester.pumpAndSettle();
    expect(find.text('Animated'), findsNothing);
    when(mockCardBloc.currentPage).thenAnswer((_) => 1);

    await tester.tap(
      find.byType(ElevatedButton).last,
    );

    await tester.pump(
      const Duration(seconds: 1),
    );
    expect(find.text('Animated'), findsOneWidget);
    expect(find.text('$kCardListPageNumberString 1'), findsOneWidget);
  });
  testWidgets(
      'verify that clicking PrevPage button changes CurrentPage to the previous and updates the list of cards',
      (tester) async {
    when(mockCardBloc.currentPage).thenReturn(1);
    await tester.pumpWidget(
      MaterialApp(
        home: CardList(
          cardBloc: mockCardBloc,
        ),
      ),
    );

    streamController.sink.add(
      CardEvent(cardState: CardState.success, cards: []),
    );
    await tester.pumpAndSettle();
    expect(find.text('Animated'), findsNothing);
    when(mockCardBloc.currentPage).thenAnswer((_) => 0);
    await tester.tap(
      find.byType(ElevatedButton).first,
    );

    await tester.pumpAndSettle();
    expect(find.text('Animated'), findsOneWidget);
    expect(find.text('$kCardListPageNumberString 0'), findsOneWidget);
  });

  testWidgets(
      'verify that clicking PrevPage button  when the App starts, CurrentPage remains 0',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CardList(
          cardBloc: mockCardBloc,
        ),
      ),
    );
    streamController.sink.add(
      CardEvent(cardState: CardState.success, cards: cardListApiFull),
    );
    await tester.pumpAndSettle();
    await tester.tap(
      find.byType(ElevatedButton).first,
    );
    await tester.pump(
      const Duration(seconds: 1),
    );
    expect(find.text('$kCardListPageNumberString 0'), findsOneWidget);
  });
}
