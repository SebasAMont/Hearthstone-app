import 'package:flutter/material.dart';
import '../../core/util/card_state.dart';
import '../../core/util/constants_api_calls.dart';
import '../../core/util/constants_assets.dart';
import '../../core/util/constants_dimensions.dart';
import '../../core/util/constants_logic.dart';
import '../../core/util/constants_strings.dart';
import '../../data/model/card_event.dart';
import '../bloc/card_bloc.dart';
import '../widget/image_box.dart';
import 'card_page.dart';

class CardList extends StatefulWidget {
  final CardBloc cardBloc;

  const CardList({
    required this.cardBloc,
    super.key,
  });

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  late String _currentUrl = kRacesDemonEndPointApi;
  late String actualPage = kCardListActualPage;

  @override
  void initState() {
    super.initState();
    widget.cardBloc.initialize();
  }

  @override
  void dispose() {
    widget.cardBloc.dispose();
    super.dispose();
  }

  Future<void> updateCurrentPage() async {
    setState(() {
      actualPage = widget.cardBloc.currentPage.toString();
    });
  }

  Future<void> changeUrl(String endpoint) async {
    _currentUrl = endpoint;
    widget.cardBloc.cardListSink.add(
      CardEvent(
        cardState: CardState.loading,
      ),
    );
    widget.cardBloc.getCardListFromEndpoint(
      _currentUrl,
    );
    updateCurrentPage();
    Navigator.pop(
      context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Center(
            child: Text(
              appBarCardListTitle,
              style: TextStyle(
                fontSize: appBarCardListTitleFontSize,
              ),
            ),
          ),
          backgroundColor: Colors.black,
        ),
        endDrawer: Drawer(
          backgroundColor: Colors.cyanAccent,
          width: kCardListDrawerWidth,
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.purple,
                  border: Border.all(
                    width: kCardListDrawerHeaderWidth,
                  ),
                  borderRadius:
                      BorderRadius.circular(kCardListDrawerHeaderWidth),
                ),
                curve: Curves.fastLinearToSlowEaseIn,
                child: const Text(
                  kCardListDrawerTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: cardTextInfoFontSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                title: Title(
                  color: Colors.black,
                  child: const Text(
                    kCardListTotems,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: cardTextInfoFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () {
                  changeUrl(kRacesTotemEndPointApi);
                },
              ),
              ListTile(
                title: Title(
                  color: Colors.black,
                  child: const Text(
                    kCardListMurlocs,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: cardTextInfoFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () {
                  changeUrl(kRacesMurlocEndPointApi);
                },
              ),
              ListTile(
                title: Title(
                  color: Colors.black,
                  child: const Text(
                    kCardListDemons,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: cardTextInfoFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () {
                  changeUrl(kRacesDemonEndPointApi);
                },
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    assetPathBackgroundImage,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: cardTextPaddingLeftTopRight,
                      top: cardTextPaddingLeftTopRight,
                      right: cardTextPaddingLeftTopRight,
                      bottom: cardTextPaddingBottom,
                    ),
                    child: Container(
                      constraints: const BoxConstraints(
                        minHeight: kCardListBoxMinHeight,
                      ),
                      child: StreamBuilder<CardEvent>(
                        stream: widget.cardBloc.cardListStream,
                        initialData: CardEvent(cardState: CardState.loading),
                        builder: (
                          BuildContext context,
                          AsyncSnapshot<CardEvent> snapshot,
                        ) {
                          switch (snapshot.data!.cardState) {
                            case CardState.loading:
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: kCardListProgressIndStrokeWidth,
                                  backgroundColor: Colors.black,
                                  color: Colors.red,
                                ),
                              );
                            case CardState.empty:
                              return const SizedBox(
                                child: Text(
                                  kCardListEmpty,
                                ),
                              );
                            case CardState.success:
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      kCardListGridViewCrossAxisCount,
                                  mainAxisSpacing:
                                      kCardListGridViewMainAxisSpacing,
                                  crossAxisSpacing:
                                      kCardListGridViewCrossAxisSpacing,
                                ),
                                padding: const EdgeInsets.all(
                                  cardListPaddingListView,
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: snapshot.data?.cards!.length,
                                itemBuilder: (
                                  BuildContext context,
                                  index,
                                ) {
                                  return ListTile(
                                    contentPadding: const EdgeInsets.all(
                                      kCardListListTilePadding,
                                    ),
                                    title: Text(
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      snapshot.data!.cards![index].name,
                                      style: const TextStyle(
                                        fontSize: cardTextInfoFontSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Center(
                                      child: SizedBox(
                                        child: Hero(
                                          tag:
                                              '$kHeroWidgetTag${snapshot.data!.cards![index].cardId}',
                                          child: ImageBox(
                                            widgetImg: snapshot
                                                .data!.cards![index].img,
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (
                                            BuildContext context,
                                          ) =>
                                              CardPage(
                                            hearthstoneCard:
                                                snapshot.data!.cards![index],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );

                            case CardState.error:
                              return const SizedBox(
                                width: cardImageBoxSizeWidth,
                                child: Center(
                                  child: Text(
                                    kEmptyDatabase,
                                    style: TextStyle(
                                      fontSize: cardTextInfoFontSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: StreamBuilder<CardEvent>(
          stream: widget.cardBloc.cardListStream,
          initialData: CardEvent(cardState: CardState.loading),
          builder: (
            BuildContext context,
            AsyncSnapshot<CardEvent> snapshot,
          ) {
            switch (snapshot.data!.cardState) {
              case CardState.success:
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: widget.cardBloc.currentPage !=
                              kCardBlocStartingCurrentPage
                          ? () {
                              widget.cardBloc.sinkPreviousCardList();
                              updateCurrentPage();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                          horizontal:
                              kCardListFloatingActionButtonPaddingHorizontal,
                          vertical:
                              kCardListFloatingActionButtonPaddingVertical,
                        ),
                      ),
                      child: const Text(
                        kCardListFloatingActionButtonTextPrev,
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: cardTextInfoFontSize,
                          color: Colors.cyan,
                          backgroundColor: Colors.black,
                        ),
                        '$kCardListPageNumberString $actualPage',
                      ),
                    ),
                    ElevatedButton(
                      onPressed: widget.cardBloc.numberOfPagesCardList -
                                  kCardListButtonIndexLogic !=
                              widget.cardBloc.currentPage
                          ? () {
                              widget.cardBloc.sinkNextCardList();
                              updateCurrentPage();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        padding: const EdgeInsets.symmetric(
                          horizontal:
                              kCardListFloatingActionButtonPaddingHorizontal,
                          vertical:
                              kCardListFloatingActionButtonPaddingVertical,
                        ),
                      ),
                      child: const Text(
                        kCardListFloatingActionButtonTextNext,
                      ),
                    ),
                  ],
                );
              case CardState.empty:
              case CardState.loading:
              case CardState.error:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
