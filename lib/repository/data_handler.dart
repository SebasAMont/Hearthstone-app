import 'dart:convert';
import 'package:flutter/services.dart';
import '../src/card_constants.dart';
import '../src/model/card.dart';

class DataHandler {
  final List<HearthstoneCard> _cardInfo = <HearthstoneCard>[];

  Future<List<HearthstoneCard>> readCardJson() async {
    final String response = await rootBundle.loadString(
      assetPathDataHandler,
    );
    final List<dynamic> cardData = await jsonDecode(
      response,
    );
    for (int i = 0; i < cardData.length; i++) {
      final element = cardData[i];
      final hsCard = HearthstoneCard.fromJson(element);
      _cardInfo.add(hsCard);
    }
    return _cardInfo;
  }
}
