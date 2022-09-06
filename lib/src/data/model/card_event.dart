import '../../core/util/card_state.dart';
import 'card.dart';

class CardEvent {
  CardEvent({required this.cardState, this.cards});

  final List<HearthstoneCard>? cards;
  final CardState cardState;
}
