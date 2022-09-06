import 'dart:convert';
import 'package:http/http.dart';
import '../../data/datasource/remote/card_api_provider.dart';
import '../../data/model/card.dart';

class RepositoryCard {
  final CardApiProvider cardsApi;
  final Client client;

  RepositoryCard({
    required this.client,
    required this.cardsApi,
  });

  late List<HearthstoneCard> cardListApi = <HearthstoneCard>[];

  Future<List<HearthstoneCard>> addCardList(String endpoint) async {
    cardListApi = [];
    final String responseBody = await cardsApi.fetchCardList(
      endpoint,
      client,
    );
    final List<dynamic> cardsApiList = await jsonDecode(
      responseBody,
    ) as List<dynamic>;
    for (int i = 0; i < cardsApiList.length; i++) {
      final element = cardsApiList[i];
      final hsCard = HearthstoneCard.fromJson(
        element as Map<String, dynamic>,
      );
      cardListApi.add(
        hsCard,
      );
    }
    return cardListApi;
  }
}
