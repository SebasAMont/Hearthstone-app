import 'package:first_app/src/model/card.dart';
import 'package:first_app/src/visibility_text.dart';
import 'package:flutter/material.dart';
import 'card_constants.dart';

class CardPage extends StatefulWidget {
  final HearthstoneCard hearthstoneCard;

  const CardPage({
    required this.hearthstoneCard,
    Key? key,
  }) : super(
          key: key,
        );

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
                            visibleCondition: true,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardText ${widget.hearthstoneCard.text}',
                            visibleCondition:
                                (widget.hearthstoneCard.text != null),
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardMechanics ${widget.hearthstoneCard.mechanics}',
                            visibleCondition:
                                (widget.hearthstoneCard.mechanics != null),
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardHealth ${widget.hearthstoneCard.health}',
                            visibleCondition:
                                (widget.hearthstoneCard.health != null),
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardType ${widget.hearthstoneCard.type}',
                            visibleCondition: true,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardLocale ${widget.hearthstoneCard.locale}',
                            visibleCondition: true,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardId ${widget.hearthstoneCard.cardId}',
                            visibleCondition: true,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardSet ${widget.hearthstoneCard.cardSet}',
                            visibleCondition: true,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardDbfId ${widget.hearthstoneCard.dbfId}',
                            visibleCondition: true,
                          ),
                          VisibilityText(
                            cardAttribute:
                                '$cardPlayerClass ${widget.hearthstoneCard.playerClass}',
                            visibleCondition: true,
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
                              color: Colors.black,
                              width: elevatedButtonSideBorderWidthRadiusValue,
                              style: BorderStyle.solid,
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
                        "$cardPageCounterText $_counter",
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
