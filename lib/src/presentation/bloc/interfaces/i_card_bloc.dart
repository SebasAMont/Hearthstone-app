import 'dart:async';

import '../../../core/bloc/i_bloc.dart';
import '../../../data/model/card_event.dart';

abstract class ICardBloc extends IBloc {
  Stream<CardEvent> get cardListStream;

  void getCardListFromEndpoint(String endpoint);
}
