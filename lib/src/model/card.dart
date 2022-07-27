import '../card_constants.dart';

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
    return HearthstoneCard(
      dbfId: json["dbfId"] ?? emptyValueHearthstoneCardFactory,
      type: json["type"] ?? emptyValueHearthstoneCardFactory,
      cardSet: json["cardSet"] ?? emptyValueHearthstoneCardFactory,
      name: json["name"] ?? emptyValueHearthstoneCardFactory,
      cardId: json["cardId"] ?? emptyValueHearthstoneCardFactory,
      playerClass: json["playerClass"] ?? emptyValueHearthstoneCardFactory,
      locale: json["locale"] ?? emptyValueHearthstoneCardFactory,
      health: json["health"],
      mechanics:
          json["mechanics"] != null ? [json["mechanics"]?[0]["name"]] : null,
      text: json["text"],
    );
  }
}
