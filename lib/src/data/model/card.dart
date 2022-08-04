import '../../core/util/card_constants.dart';

class HearthstoneCard {
  HearthstoneCard({
    required this.cardId,
    required this.dbfId,
    required this.name,
    required this.cardSet,
    required this.type,
    required this.playerClass,
    required this.locale,
    this.text,
    this.health,
    this.mechanics,
  });

  final String cardId;
  final String? dbfId;
  final String name;
  final String cardSet;
  final String type;
  final String playerClass;
  final String locale;
  String? text;
  int? health;
  List<String>? mechanics;

  factory HearthstoneCard.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? mechanicsAux = json['mechanics'] as List<dynamic>?;
    final List<String> mechanics = [];

    if (mechanicsAux != null) {
      for (int i = 0; i < mechanicsAux.length; i++) {
        final nameAux = (mechanicsAux[i] as Map<String, dynamic>)['name'];
        mechanics.add(nameAux as String);
      }
    }

    return HearthstoneCard(
      dbfId: json['dbfId'] as String,
      type: json['type'] as String,
      cardSet: json['cardSet'] as String,
      name: json['name'] as String,
      cardId: json['cardId'] as String,
      playerClass: json['playerClass'] as String,
      locale: json['locale'] as String,
      health: json['health'] as int? ?? defaultCardHealth,
      mechanics: mechanics,
      text: json['text'] as String?,
    );
  }
}
