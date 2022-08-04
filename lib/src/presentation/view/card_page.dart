import 'package:first_app/src/data/model/card.dart';
import 'package:first_app/src/presentation/widget/visibility_text.dart';
import 'package:flutter/material.dart';
import '../../core/util/card_constants.dart';

class CardPage extends StatefulWidget {
  final HearthstoneCard hearthstoneCard;

  const CardPage({
    required this.hearthstoneCard,
    super.key,
  });

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  int _counter = counterInitialValue;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            appBarCardPageTitle,
            style: TextStyle(
              fontSize: appBarCardPageTitleFontSize,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Stack(
              children: [
                Container(
                  height: backgroundImageContainerHeight,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        assetPathBackgroundImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        left: cardTextPaddingLeftTopRight,
                        top: cardTextPaddingLeftTopRight,
                        right: cardTextPaddingLeftTopRight,
                        bottom: cardTextPaddingBottom,
                      ),
                      child: Column(
                        children: <Widget>[
                          VisibilityText(
                            cardAttribute:
                                '$cardName  ${widget.hearthstoneCard.name}',
                            isVisible: true,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardText ${widget.hearthstoneCard.text}',
                            isVisible: widget.hearthstoneCard.text != null,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardHealth ${widget.hearthstoneCard.health}',
                            isVisible: widget.hearthstoneCard.health !=
                                defaultCardHealth,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardType ${widget.hearthstoneCard.type}',
                            isVisible: true,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardLocale ${widget.hearthstoneCard.locale}',
                            isVisible: true,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardId ${widget.hearthstoneCard.cardId}',
                            isVisible: true,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardSet ${widget.hearthstoneCard.cardSet}',
                            isVisible: true,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardDbfId ${widget.hearthstoneCard.dbfId}',
                            isVisible: true,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardPlayerClass ${widget.hearthstoneCard.playerClass}',
                            isVisible: true,
                          ),
                          Visibility(
                            visible:
                                widget.hearthstoneCard.mechanics!.isNotEmpty,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: cardPageListViewPaddingTop,
                                  ),
                                  child: VisibilityText(
                                    cardAttribute: cardMechanics,
                                    isVisible: widget
                                        .hearthstoneCard.mechanics!.isNotEmpty,
                                  ),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(
                                      cardListPaddingListView,
                                    ),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: widget
                                        .hearthstoneCard.mechanics!.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return VisibilityText(
                                        cardAttribute:
                                            ' ${widget.hearthstoneCard.mechanics![index]}',
                                        isVisible: widget.hearthstoneCard
                                            .mechanics!.isNotEmpty,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: cardImageBoxSizeWidth,
                      height: cardImageBoxSizeHeight,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Image.asset(
                          assetPathCardImage,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _incrementCounter,
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.resolveWith(
                          (states) => elevatedButtonElevationValue,
                        ),
                        shape: MaterialStateProperty.resolveWith(
                          (states) => RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              elevatedButtonShapeBorderRadiusValue,
                            ),
                            side: const BorderSide(
                              width: elevatedButtonSideBorderWidthRadiusValue,
                            ),
                          ),
                        ),
                        shadowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.purple,
                        ),
                        backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.deepPurple,
                        ),
                      ),
                      child: Text(
                        '$cardPageCounterText $_counter',
                        style: const TextStyle(
                          fontSize: counterTextFontSize,
                          color: Colors.cyanAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
