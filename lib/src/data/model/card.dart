import '../../core/util/constants_logic.dart';
import '../../domain/entity/entity_abstract_card.dart';

class HearthstoneCard extends EntityAbstractCard {
  HearthstoneCard({
    required super.cardId,
    required super.name,
    super.locale,
    super.cardSet,
    super.dbfId,
    super.type,
    super.text,
    super.img,
    super.playerClass,
    super.classes,
    super.rarity,
    super.mechanics,
    super.health,
    super.artist,
    super.attack,
    super.collectible,
    super.cost,
    super.elite,
    super.faction,
    super.flavor,
    super.howToGet,
    super.howToGetGold,
    super.imgGold,
    super.multiClassGroup,
    super.race,
  });

  factory HearthstoneCard.fromJson(Map<String, dynamic> json) {
    final List<dynamic>? mechanicsAux = json['mechanics'] as List<dynamic>?;
    final List<String> mechanics = [];
    final List<dynamic>? classesAux = json['classes'] as List<dynamic>?;
    final List<String> classes = [];

    if (classesAux != null) {
      for (int i = 0; i < classesAux.length; i++) {
        final nameClassAux = classesAux[i];
        classes.add(nameClassAux as String);
      }
    }

    if (mechanicsAux != null) {
      for (int i = 0; i < mechanicsAux.length; i++) {
        final nameMecAux = (mechanicsAux[i] as Map<String, dynamic>)['name'];
        mechanics.add(nameMecAux as String);
      }
    }

    return HearthstoneCard(
      dbfId: json['dbfId'] as int?,
      cardSet: json['cardSet'] as String?,
      name: json['name'] as String,
      cardId: json['cardId'] as String,
      locale: json['locale'] as String?,
      type: json['type'] as String?,
      img: json['img'] as String?,
      imgGold: json['imgGold'] as String?,
      playerClass: json['playerClass'] as String?,
      text: json['text'] as String?,
      rarity: json['rarity'] as String?,
      race: json['race'] as String?,
      faction: json['faction'] as String?,
      flavor: json['flavor'] as String?,
      artist: json['artist'] as String?,
      howToGet: json['howToGet'] as String?,
      howToGetGold: json['howToGetGold'] as String?,
      multiClassGroup: json['multiClassGroup'] as String?,
      health: json['health'] as int? ?? defaultCardHealth,
      cost: json['cost'] as int?,
      attack: json['attack'] as int?,
      collectible: json['collectible'] as bool?,
      elite: json['elite'] as bool?,
      mechanics: mechanics,
      classes: classes,
    );
  }
}
