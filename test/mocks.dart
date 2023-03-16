import 'package:first_app/src/core/util/card_state.dart';
import 'package:first_app/src/core/util/constants_api_calls.dart';
import 'package:first_app/src/data/model/card.dart';
import 'package:first_app/src/data/model/card_event.dart';

String jsonMock =
    '[{ "cardId":"NEW1_009", "dbfId":764, "name":"Healing Totem", "cardSet":"Legacy", "type":"Minion", "rarity":"Free","cost":1,"attack":0,"health":2,"text":"At the end of your turn, restore #1 Health to all friendly minions.","race":"Totem","playerClass":"Shaman","img":"https://d15f34w2p8l1cc.cloudfront.net/hearthstone/0b5a0bc218eb7f02aa027803d43a10b71e69428c212ad6a94976906ee0882327.png","locale":"enUS"}]';
final List<dynamic> cardListApi = <dynamic>[
  {
    'cardId': 'NEW1_009',
    'dbfId': 764,
    'name': 'Healing Totem',
    'cardSet': 'Legacy',
    'type': 'Minion',
    'rarity': 'Free',
    'cost': 1,
    'attack': 0,
    'health': 3,
    'text':
        'At the end of your turn, restore #1 Health to all friendly minions.',
    'race': 'Totem',
    'playerClass': 'Shaman',
    'img':
        'https://d15f34w2p8l1cc.cloudfront.net/hearthstone/0b5a0bc218eb7f02aa027803d43a10b71e69428c212ad6a94976906ee0882327.png',
    'locale': 'enUS'
  },
  {
    'cardId': 'NEW1_009',
    'dbfId': 764,
    'name': 'Healing Totem',
    'cardSet': 'Legacy',
    'type': 'Minion',
    'rarity': 'Free',
    'cost': 1,
    'attack': 0,
    'health': 1,
    'text':
        'At the end of your turn, restore #1 Health to all friendly minions.',
    'race': 'Totem',
    'playerClass': 'Shaman',
    'img':
        'https://d15f34w2p8l1cc.cloudfront.net/hearthstone/0b5a0bc218eb7f02aa027803d43a10b71e69428c212ad6a94976906ee0882327.png',
    'locale': 'enUS'
  },
  {
    'cardId': 'NEW1_009',
    'dbfId': 764,
    'name': 'Healing Totem',
    'cardSet': 'Legacy',
    'type': 'Minion',
    'rarity': 'Free',
    'cost': 1,
    'attack': 0,
    'health': 2,
    'text':
        'At the end of your turn, restore #1 Health to all friendly minions.',
    'race': 'Totem',
    'playerClass': 'Shaman',
    'img':
        'https://d15f34w2p8l1cc.cloudfront.net/hearthstone/0b5a0bc218eb7f02aa027803d43a10b71e69428c212ad6a94976906ee0882327.png',
    'locale': 'enUS'
  }
];
final List<HearthstoneCard> cardListApiEmpty = <HearthstoneCard>[];
HearthstoneCard cardA = HearthstoneCard(
  cardId: 'Animated',
  dbfId: 1,
  name: 'Animated',
  cardSet: 'ju',
  locale: 'adsf',
  type: 'dragon',
);
HearthstoneCard cardB = HearthstoneCard(
  cardId: 'Animated',
  dbfId: 3,
  name: 'a',
  cardSet: 'ju',
  locale: 'adsf',
  type: 'dragon',
);
final CardEvent cardEventEmpty = CardEvent(cardState: CardState.empty);
HearthstoneCard cardC = HearthstoneCard(
  cardId: 'Animated',
  dbfId: 2,
  name: 'a',
  cardSet: 'ju',
  locale: 'adsf',
  type: 'dragon',
);
final List<HearthstoneCard> cardListApiFull = <HearthstoneCard>[
  cardA,
  cardB,
  cardC,
];
final List<HearthstoneCard> tenCardsMock = <HearthstoneCard>[
  cardA,
  cardB,
  cardC,
  cardB,
  cardB,
  cardB,
  cardB,
  cardB,
  cardB,
  cardC,
];
const String badEndpoint = 's#s#';
const int cardCorrupt = 5;
const String cardListResponseBody =
    '[{"cardId":"YOD_032e","dbfId": 56323 ,"name":"Frenzied","cardSet":"Galakronds Awakening","type":"Enchantment","text":"Cost reduced.","race":"Demon","playerClass":"Neutral","locale":"enUS","mechanics":[{"name":"OneTurnEffect"}]}]';
const String emptyCardResponseBodyList = '[]';
const String cardListResponseBodyCorrupt =
    '[{"cardId":6,"dbfId": 56323 ,"name":true,"cardSet":"Galakronds Awakening","type":"Enchantment","text":"Cost reduced.","race":"Demon","playerClass":"Neutral","locale":"enUS","mechanics":[{"name":"OneTurnEffect"}]}]';
final List<dynamic> cardListCorrupt = [
  {
    'cardId': true,
    'dbfId': 764,
    'name': 'Healing Totem',
    'cardSet': 'Legacy',
    'type': 'Minion',
    'rarity': 'Free',
    'cost': 1,
    'attack': 0,
    'health': 2,
    'text':
        'At the end of your turn, restore #1 Health to all friendly minions.',
    'race': 'Totem',
    'playerClass': 'Shaman',
    'img':
        'https://d15f34w2p8l1cc.cloudfront.net/hearthstone/0b5a0bc218eb7f02aa027803d43a10b71e69428c212ad6a94976906ee0882327.png',
    'locale': 'enUS'
  }
];

const defaultEndpoint = kRacesDemonEndPointApi;

const Map<String, dynamic> jsonMockito = {
  'cardId': 'LOEA06_03eh',
  'dbfId': 38589,
  'name': 'Animated',
  'cardSet': 'The League of Explorers',
  'type': 'Enchantment',
  'text': '+3/+3 and <b>Taunt</b>.',
  'playerClass': 'Neutral',
  'locale': 'enUS',
};
const Map<String, dynamic> jsonMockitoCorrupted = {
  'cardId': 3,
  'dbfId': 38589,
  'name': true,
  'cardSet': 'The League of Explorers',
  'type': 'Enchantment',
  'text': '+3/+3 and <b>Taunt</b>.',
  'playerClass': 'Neutral',
  'locale': 'enUS'
};
