import 'dart:convert';
import 'package:flutter/services.dart';
import '../../core/util/card_constants.dart';
import '../model/card.dart';

class DataHandler {
  final List<HearthstoneCard> _cardInfo = <HearthstoneCard>[];

  Future<List<HearthstoneCard>> readCardJson() async {
    final String response = await rootBundle.loadString(
      assetPathDataHandler,
    );
    final List<dynamic> cardData = await jsonDecode(
      response,
    ) as List<dynamic>;
    for (int i = 0; i < cardData.length; i++) {
      final element = cardData[i];
      final hsCard = HearthstoneCard.fromJson(element as Map<String, dynamic>);
      _cardInfo.add(hsCard);
    }
    return _cardInfo;
  }
}
