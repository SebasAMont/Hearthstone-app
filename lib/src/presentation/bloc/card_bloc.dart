import 'dart:async';
import '../../core/util/card_state.dart';
import '../../core/util/constants_api_calls.dart';
import '../../core/util/constants_logic.dart';
import '../../core/util/constants_strings.dart';
import '../../data/model/card.dart';
import '../../data/model/card_event.dart';
import '../../domain/repository/repository_card.dart';
import '../../domain/usecase/implementation/fetch_data_usecase.dart';
import 'interfaces/i_card_bloc.dart';

class CardBloc extends ICardBloc {
  final RepositoryCard repositoryCard;
  final defaultEndpoint = kRacesDemonEndPointApi;
  int firstCardOfPage = cardBlocStartingPositionOfShowedCards;
  int lastCardOfPage = kCardBlocNumberOfCardsShowedPerPage;
  int currentPage = kCardBlocStartingCurrentPage;
  late List<HearthstoneCard> allCards = [];
  int numberOfPagesCardList = kDefaultNumberOfPagesCardList;

  Map<int, List<HearthstoneCard>> page = {};
  FetchDataUseCase fetchDataUseCase;

  CardBloc({
    required this.repositoryCard,
    required this.fetchDataUseCase,
  });

  final StreamController<CardEvent> _streamController =
      StreamController<CardEvent>.broadcast();

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  Future<void> initialize() async {
    await getCardListFromEndpoint(
      defaultEndpoint,
    );
  }

  Sink<CardEvent> get cardListSink => _streamController.sink;

  @override
  Stream<CardEvent> get cardListStream => _streamController.stream;

  @override
  Future<void> getCardListFromEndpoint(String endpoint) async {
    currentPage = kCardBlocStartingCurrentPage;

    await fillAllCardsList(
      endpoint,
    );

    numberOfPagesCardList =
        (allCards.length / kCardBlocNumberOfCardsShowedPerPage).ceil();
    sinkCurrentCardList();
  }

  Future<void> fillAllCardsList(String endpoint) async {

    allCards = await repositoryCard.addCardList(
      endpoint,
    );

    try {
      allCards = await fetchDataUseCase.fetchData(
        endpoint: endpoint,
      );
    } catch (e) {
      _streamController.sink.add(
        CardEvent(cardState: CardState.error),
      );
      return Future.error(kEmptyDatabase);
    }

  }

  Future<void> sinkCurrentCardList() async {
    List<HearthstoneCard> tenCards = <HearthstoneCard>[];
    firstCardOfPage = currentPage * kCardBlocNumberOfCardsShowedPerPage;
    lastCardOfPage = firstCardOfPage + kCardBlocNumberOfCardsShowedPerPage;
    lastCardOfPage < allCards.length
        ? tenCards = allCards
            .getRange(
              firstCardOfPage,
              lastCardOfPage,
            )
            .toList()
        : tenCards = allCards
            .getRange(
              firstCardOfPage,
              allCards.length,
            )
            .toList();

    page[currentPage] = tenCards;

    _streamController.sink.add(
      CardEvent(
        cardState: CardState.success,
        cards: tenCards,
      ),
    );
  }

  Future<void> sinkNextCardList() async {
    if (currentPage < numberOfPagesCardList - kCardBlocNextCardIndexFixer) {
      currentPage++;
      sinkCurrentCardList();
    }
  }

  Future<void> sinkPreviousCardList() async {
    if (currentPage > kCardBlocStartingCurrentPage) {
      currentPage--;

      _streamController.sink.add(
        CardEvent(
          cardState: CardState.success,
          cards: page[currentPage],
        ),
      );
    }
  }

  Future<void> sinkAllCardList(String endpoint) async {
    await fillAllCardsList(
      endpoint,
    );
    _streamController.sink.add(
      CardEvent(
        cardState: CardState.success,
        cards: allCards,
      ),
    );
  }
}
