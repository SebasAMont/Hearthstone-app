abstract class EntityAbstractCard {
  EntityAbstractCard({
    required this.cardId,
    required this.name,
    this.locale,
    this.cardSet,
    this.dbfId,
    this.type,
    this.img,
    this.imgGold,
    this.playerClass,
    this.text,
    this.health,
    this.mechanics,
    this.rarity,
    this.race,
    this.faction,
    this.cost,
    this.attack,
    this.flavor,
    this.artist,
    this.collectible,
    this.elite,
    this.howToGet,
    this.howToGetGold,
    this.multiClassGroup,
    this.classes,
  });

  final String cardId;
  final int? dbfId;
  final String name;
  final String? cardSet;
  final String? locale;
  String? type;
  String? img;
  String? imgGold;
  String? race;
  String? playerClass;
  String? rarity;
  String? text;
  String? faction;
  String? flavor;
  String? artist;
  String? howToGet;
  String? howToGetGold;
  String? multiClassGroup;
  bool? collectible;
  bool? elite;
  int? cost;
  int? attack;
  int? health;
  List<String>? mechanics;
  List<String>? classes;
}
