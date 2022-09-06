import 'package:first_app/src/core/util/constants_api_calls.dart';
import 'package:first_app/src/data/datasource/remote/card_api_provider.dart';
import 'package:first_app/src/data/model/card.dart';
import 'package:first_app/src/domain/repository/repository_card.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'fetch_card_list_test.mocks.dart';
import 'mocks.dart';
import 'repository_card_add_card_test.mocks.dart';

@GenerateMocks([CardApiProvider])
void main() {
  late MockClient client;
  late MockCardApiProvider cardApiProvider;
  late RepositoryCard repositoryCard;

  setUp(() {
    client = MockClient();
    cardApiProvider = MockCardApiProvider();
    repositoryCard = RepositoryCard(
      client: client,
      cardsApi: cardApiProvider,
    );
  });

  group('addCardList', () {
    test('Add the list of cards and returns it, if it is successful', () async {
      when(
        cardApiProvider.fetchCardList(
          kRacesTotemEndpointApi,
          client,
        ),
      ).thenAnswer((_) async => cardListResponseBody);
      expect(
        await repositoryCard.addCardList(kRacesTotemEndpointApi),
        isA<List<HearthstoneCard>>(),
      );
    });
    test(
        'Add the list of cards being empty and returns it, if it is successful',
        () async {
      when(
        cardApiProvider.fetchCardList(
          kRacesTotemEndpointApi,
          client,
        ),
      ).thenAnswer((_) async => emptyCardResponseBodyList);
      expect(
        await repositoryCard.addCardList(kRacesTotemEndpointApi),
        isA<List<HearthstoneCard>>(),
      );
    });
    test(
        'Add the list of cards with corrupted data and returns it as an error, if it is successful',
        () async {
      when(
        cardApiProvider.fetchCardList(
          kRacesTotemEndpointApi,
          client,
        ),
      ).thenAnswer((_) async => cardListResponseBodyCorrupt);
      expect(
        () async => repositoryCard.addCardList(kRacesTotemEndpointApi),
        throwsA(
          const TypeMatcher<TypeError>(),
        ),
      );
    });
    test('The method receives a wrong endpoint and should throw Exception',
        () async {
      when(
        cardApiProvider.fetchCardList(
          badEndpoint,
          client,
        ),
      ).thenThrow(
        Exception(kApiFetchCardError),
      );
      expect(
        () async => repositoryCard.addCardList(badEndpoint),
        throwsException,
      );
    });
  });
}
