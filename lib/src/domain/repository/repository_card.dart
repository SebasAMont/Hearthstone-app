import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart';
import '../../core/util/constants_api_calls.dart';
import '../../core/util/constants_strings.dart';
import '../../data/datasource/remote/card_api_provider.dart';
import '../../data/model/card.dart';
import '../../data/datasource/local/DAOs/card_database.dart';

class RepositoryCard {
  final CardApiProvider cardsApi;
  final Client client;
  final CardDatabase cardDatabase;

  RepositoryCard({
    required this.client,
    required this.cardsApi,
    required this.cardDatabase,
  });

  late List<HearthstoneCard> cardListApi = <HearthstoneCard>[];

  Future<List<dynamic>> fetchDocumentSnapshot({
    required String subCollection,
  }) async {
    final List<dynamic> documentList = [];
    final QuerySnapshot documentSnapshot = await cardDatabase.readItems(
      subCollectionDoc: subCollection,
    );
    final List<QueryDocumentSnapshot> docCards = documentSnapshot.docs;

    for (final doc in docCards) {
      documentList.add(
        doc.data(),
      );
    }
    if (documentList.isEmpty) {
      throw Exception(kEmptyDatabase);
    }
    return documentList;
  }

  void addCardBase(
    String endpoint,
    List<dynamic> cardsApiList,
  ) {
    switch (endpoint) {
      case kRacesDemonEndPointApi:
        cardDatabase.addItem(
          cardList: cardsApiList,
          subCollectionDoc: kMainCollectionDocDemon,
        );
        break;
      case kRacesTotemEndPointApi:
        cardDatabase.addItem(
          cardList: cardsApiList,
          subCollectionDoc: kMainCollectionDocTotem,
        );
        break;
      case kRacesMurlocEndPointApi:
        cardDatabase.addItem(
          cardList: cardsApiList,
          subCollectionDoc: kMainCollectionDocMurloc,
        );
        break;
    }
  }

  Future<List<HearthstoneCard>> addCardList(String endpoint) async {
    cardListApi = [];
    List<dynamic> cardsApiList = [];
    try {
      final responseBody = await cardsApi.fetchCardList(
        endpoint,
        client,
      );
      cardsApiList = jsonDecode(
        responseBody,
      ) as List<dynamic>;
      addCardBase(
        endpoint,
        cardsApiList,
      );
    } catch (database) {
      try {
        switch (endpoint) {
          case kRacesDemonEndPointApi:
            cardsApiList = await fetchDocumentSnapshot(
              subCollection: kMainCollectionDocDemon,
            );
            break;
          case kRacesTotemEndPointApi:
            cardsApiList = await fetchDocumentSnapshot(
              subCollection: kMainCollectionDocTotem,
            );

            break;
          case kRacesMurlocEndPointApi:
            cardsApiList = await fetchDocumentSnapshot(
              subCollection: kMainCollectionDocTotem,
            );

            break;
        }
      } catch (e) {
        return Future.error(kEmptyDatabase);
      }
    }

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
