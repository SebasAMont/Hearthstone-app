import 'package:first_app/src/data/model/card_event.dart';
import 'package:first_app/src/domain/repository/repository_card.dart';
import 'package:first_app/src/domain/usecase/implementation/fetch_data_usecase.dart';
import 'package:first_app/src/presentation/bloc/card_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'card_bloc_test.mocks.dart';

import 'mocks.dart';

@GenerateMocks([RepositoryCard])
void main() {
  late MockRepositoryCard repositoryCard;
  late CardBloc cardBloc;
  late FetchDataUseCase fetchDataUseCase;

  setUp(() {
    repositoryCard = MockRepositoryCard();
    fetchDataUseCase = FetchDataUseCase(repositoryCard: repositoryCard);
    cardBloc = CardBloc(
      repositoryCard: repositoryCard,
      fetchDataUseCase: fetchDataUseCase,
    );
  });

  group('fillAllCardsList', () {
    test(
        'Adds an empty list of cards to allCards calling repositoryCard.addCardList, if it is successful',
        () async {
      when(
        repositoryCard.addCardList(defaultEndpoint),
      ).thenAnswer((_) async => cardListApiEmpty);
      await cardBloc.fillAllCardsList(defaultEndpoint);
      expect(
        cardBloc.allCards.isEmpty,
        true,
      );
    });
    test(
        'Adds 3 cards to allCards calling repositoryCard.addCardList, if it is successful',
        () async {
      when(
        repositoryCard.addCardList(defaultEndpoint),
      ).thenAnswer((_) async => cardListApiFull);
      await cardBloc.fillAllCardsList(defaultEndpoint);
      expect(
        cardBloc.allCards.isNotEmpty && cardBloc.allCards.length == 3,
        true,
      );
    });
  });
  group('sinkCurrentCardList', () {
    test(
        'Sinks current card list and checks is the first element of the stream is a CardList of HearthstoneCards',
        () async {
      await cardBloc.sinkCurrentCardList();
      expect(
        cardBloc.cardListStream.first,
        isA<Future<CardEvent>>(),
      );
    });
  });
}
